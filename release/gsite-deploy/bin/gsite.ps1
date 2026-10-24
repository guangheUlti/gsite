# ---------------------------------------------------------------------------
# GSite deploy engine (Windows, self-contained package).
# Every *.bat in this package is only a thin wrapper around this script.
#
#   -Action render             render templates/ -> real config files
#   -Action preflight          check the package / config.bat / ports without changing anything
#   -Action init               render + init mysql data dir + create db + import sql
#   -Action start              start components (service / boot task aware)
#   -Action stop               stop components
#   -Action restart            stop + start
#   -Action status             show running state
#   -Action launch             start raw processes only (used by the boot task)
#   -Action health             probe the four TCP ports (exit 1 when down)
#   -Action install-service    register as Windows service / boot task
#   -Action uninstall-service  remove them
#
#   -Component  mysql|redis|backend|nginx|app|all   (default all)
#   -Force                     re-import the seed sql even when the db exists
# ---------------------------------------------------------------------------
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$Action,
    [string]$Component = 'all',
    [switch]$Force
)

# native tools (mysql, mysqld, nginx, taskkill, schtasks) love to write on stderr
# even when they succeed, so do not turn that into a terminating error: every
# external call below checks $LASTEXITCODE / the resulting state explicitly instead.
$ErrorActionPreference = 'Continue'

# --------------------------------------------------------------------------- paths
$PKG    = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$TPLDIR = Join-Path $PKG 'templates'
$RUNDIR = Join-Path $PKG 'run'
$LOGDIR = Join-Path $PKG 'logs'
$JRE    = Join-Path $PKG 'jre'
$BACKEND = Join-Path $PKG 'server'
$MYSQL   = Join-Path $PKG 'mysql'
$REDIS   = Join-Path $PKG 'redis'
$NGX     = Join-Path $PKG 'nginx'
$SQLDIR  = Join-Path $PKG 'sql'
# single source for the seed list: pre-flight and init must agree on it
$SEED_SQL = @('gsite.sql', 'quartz.sql', 'gsite_modules.sql')
# the backend jar is compiled for Java 25 (Spring Boot 3.5) - a JDK 8 runtime cannot load it at all
$MIN_JAVA = 25
foreach ($d in @($RUNDIR, $LOGDIR, "$BACKEND\logs", "$MYSQL\logs", "$REDIS\logs", "$NGX\logs", "$NGX\temp")) {
    if (-not (Test-Path $d)) { New-Item -ItemType Directory -Path $d | Out-Null }
}

function Fwd([string]$p) { return ($p -replace '\\', '/') }
function Ts { return (Get-Date).ToString('yyyy-MM-dd HH:mm:ss') }
function Say([string]$m) { Write-Host ("[{0}] {1}" -f (Ts), $m) }
function Warn([string]$m) { Write-Host ("[{0}] [WARN] {1}" -f (Ts), $m) -ForegroundColor Yellow }
function Die([string]$m) { Write-Host ("[{0}] [FAIL] {1}" -f (Ts), $m) -ForegroundColor Red; exit 1 }

# --------------------------------------------------------------------------- config.bat
$E = @{}
$envFile = Join-Path $PKG 'config.bat'
if (-not (Test-Path $envFile)) { Die "config.bat not found: $envFile" }
foreach ($line in (Get-Content $envFile -Encoding ASCII)) {
    if ($line -match '^\s*set\s+([A-Za-z0-9_]+)\s*=\s*(.*?)\s*$') {
        $k = $Matches[1]; $v = $Matches[2]
        if ($v -match '^"(.*)"$') { $v = $Matches[1] }
        $E[$k] = $v
    }
}
foreach ($need in @('WEB_PORT','BACKEND_PORT','MYSQL_PORT','MYSQL_DB','MYSQL_ROOT_PASSWORD','MYSQL_APP_USER',
                    'MYSQL_APP_PASSWORD','REDIS_PORT','REDIS_PASSWORD','JAVA_XMS','JAVA_XMX','SPRING_PROFILE',
                    'SERVICE_PREFIX')) {
    if (-not $E.ContainsKey($need)) { Die "config.bat is missing key: $need" }
}
# derived keys, consumed by the templates
$E['PKG_DIR']       = Fwd $PKG
$E['MYSQL_BASEDIR'] = Fwd $MYSQL
$E['MYSQL_DATADIR'] = Fwd (Join-Path $MYSQL 'data')
$E['MYSQL_LOGDIR']  = Fwd (Join-Path $MYSQL 'logs')
$E['REDIS_DIR']     = Fwd $REDIS
$E['WEB_ROOT']      = Fwd (Join-Path $NGX 'html')
$E['BACKEND_DIR']   = Fwd $BACKEND
if ($E['REDIS_PASSWORD'] -eq '') {
    $E['REDIS_REQUIREPASS'] = '# requirepass is disabled (redis listens on 127.0.0.1 only)'
    # redisson sends AUTH as soon as the property is present, even when empty
    $E['REDIS_PASSWORD_LINE'] = '# no password'
} else {
    $E['REDIS_REQUIREPASS'] = 'requirepass ' + $E['REDIS_PASSWORD']
    $E['REDIS_PASSWORD_LINE'] = 'password: "' + $E['REDIS_PASSWORD'] + '"'
}
$PFX         = $E['SERVICE_PREFIX']
$MYSQL_NAME  = $PFX + '-MySQL'
$REDIS_NAME  = $PFX + '-Redis'
$APP_TASK    = $PFX + '-App'

$exeMysqld  = Join-Path $MYSQL 'bin\mysqld.exe'
$exeMysql   = Join-Path $MYSQL 'bin\mysql.exe'
$exeMysqlad = Join-Path $MYSQL 'bin\mysqladmin.exe'
$iniMysql   = Join-Path $MYSQL 'my.ini'
$confRedis  = Join-Path $REDIS 'redis.conf'
$confNginx  = Join-Path $NGX 'conf\nginx.conf'
$cfgApp     = Join-Path $BACKEND 'config\application-deploy.yaml'

# --------------------------------------------------------------------------- small helpers
function Test-Admin {
    $id = [Security.Principal.WindowsIdentity]::GetCurrent()
    return (New-Object Security.Principal.WindowsPrincipal $id).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}
function Test-Service([string]$name) { return [bool](Get-Service -Name $name -ErrorAction SilentlyContinue) }
function Test-Task([string]$name) {
    & schtasks.exe @('/query', '/tn', $name) 2>$null | Out-Null
    return ($LASTEXITCODE -eq 0)
}
function PortOf([string]$Name) {
    switch ($Name) {
        'mysql'   { return [int]$E['MYSQL_PORT'] }
        'redis'   { return [int]$E['REDIS_PORT'] }
        'backend' { return [int]$E['BACKEND_PORT'] }
        'nginx'   { return [int]$E['WEB_PORT'] }
        default   { return 0 }
    }
}
function Test-Port([int]$port) {
    if ($port -le 0) { return $true }
    try {
        $c = New-Object Net.Sockets.TcpClient
        $r = $c.BeginConnect('127.0.0.1', $port, $null, $null)
        if ($r.AsyncWaitHandle.WaitOne(400) -and $c.Connected) { $c.Close(); return $true }
        $c.Close(); return $false
    } catch { return $false }
}
function Wait-Port([int]$port, [string]$what, [int]$timeout) {
    $end = (Get-Date).AddSeconds($timeout)
    while ((Get-Date) -lt $end) { if (Test-Port $port) { return $true }; Start-Sleep -Seconds 1 }
    Warn "$what did not come up on port $port within $timeout s"
    return $false
}
function NoLongerOnPort([int]$port, [string]$what, [int]$timeout) {
    $end = (Get-Date).AddSeconds($timeout)
    while ((Get-Date) -lt $end) { if (-not (Test-Port $port)) { return $true }; Start-Sleep -Milliseconds 500 }
    Warn "$what still holds port $port after $timeout s"
    return $false
}
# --------------------------------------------------------------------------- port ownership
# This package must never reconfigure or shut down a MySQL / Redis that belongs to
# another installation, so a busy port is only treated as "ours" when it can be proven.
function PortOwnerPids([int]$port) {
    $res = @()
    foreach ($l in (& netstat.exe @('-ano', '-p', 'tcp') 2>$null)) {
        if ($l -match '^\s*TCP\s+\S+:(\d+)\s+\S+\s+LISTENING\s+(\d+)\s*$') {
            if ([int]$matches[1] -eq $port) { $res += [int]$matches[2] }
        }
    }
    return @($res | Sort-Object -Unique)
}
function ProcName([int]$thePid) {
    try { return (Get-Process -Id $thePid -ErrorAction Stop) } catch { return $null }
}
function ImageName([string]$Name) {
    switch ($Name) {
        'mysql'   { return 'mysqld' }
        'redis'   { return 'redis-server' }
        'nginx'   { return 'nginx' }
        'backend' { return 'java' }
    }
    return ''
}
function Test-PortOurs([int]$port, [string]$Name) {
    # 1) started by this package and tracked in run\<name>.pid
    $p = PidOfFile $Name
    if ($null -ne $p) {
        $o = ProcName $p
        if ($o -and $o.ProcessName -eq (ImageName $Name)) { return $true }
    }
    # 2) running as the service / boot task registered by install-service.bat
    switch ($Name) {
        'mysql'   { if (Test-Service $MYSQL_NAME) { return $true } }
        'redis'   { if ((Test-Service $REDIS_NAME) -or (Test-Task $REDIS_NAME)) { return $true } }
        'backend' { if (Test-Task $APP_TASK) { return $true } }
        'nginx'   { if (Test-Task $APP_TASK) { return $true } }
    }
    # 3) the listener is one of our own executables
    $exe = ''
    switch ($Name) {
        'mysql' { $exe = $exeMysqld }
        'redis' { $exe = (Join-Path $REDIS 'redis-server.exe') }
        'nginx' { $exe = (Join-Path $NGX 'nginx.exe') }
    }
    if ($exe -and (Test-Path $exe)) {
        $want = (Get-Item $exe).FullName.ToLower()
        foreach ($owner in (PortOwnerPids $port)) {
            $o = ProcName $owner
            if ($o -and $o.Path -and $o.Path.ToLower() -eq $want) { return $true }
        }
    }
    return $false
}
function Assert-PortFreeOrOurs([string]$Name) {
    $port = PortOf $Name
    if (-not (Test-Port $port)) { return }
    if (Test-PortOurs $port $Name) { return }
    $who = @()
    foreach ($owner in (PortOwnerPids $port)) {
        $o = ProcName $owner
        if ($o) { $who += ('{0} (pid {1})' -f $o.ProcessName, $owner) } else { $who += ('pid ' + $owner) }
    }
    $key = switch ($Name) { 'mysql' {'MYSQL_PORT'} 'redis' {'REDIS_PORT'} 'backend' {'BACKEND_PORT'} 'nginx' {'WEB_PORT'} }
    Die ("port $port [$Name] is taken by " + (($who | Sort-Object -Unique) -join ', ') + " which is NOT part of this package - either stop that program or set $key to another port in config.bat")
}
function PidOfFile([string]$name) {
    $f = Join-Path $RUNDIR ($name + '.pid')
    if (Test-Path $f) {
        $t = (Get-Content $f -Encoding ASCII -ErrorAction SilentlyContinue | Select-Object -First 1)
        if ($t -match '^\d+$') { return [int]$t }
    }
    return $null
}
function PidAlive([int]$thePid) { return [bool](Get-Process -Id $thePid -ErrorAction SilentlyContinue) }
function Remove-PidFile([string]$name) { Remove-Item (Join-Path $RUNDIR ($name + '.pid')) -Force -ErrorAction SilentlyContinue }
function Stop-ByPid([string]$Name) {
    $p = PidOfFile $Name
    if ($null -eq $p) { return }
    if (-not (PidAlive $p)) { Remove-PidFile $Name; return }
    Say ("{0,-8} stopping pid={1}" -f $Name, $p)
    & taskkill.exe @('/PID', "$p", '/T', '/F') 2>$null | Out-Null
    $end = (Get-Date).AddSeconds(15)
    while ((Get-Date) -lt $end -and (PidAlive $p)) { Start-Sleep -Milliseconds 500 }
    Remove-PidFile $Name
}
function Start-Daemon {
    param([string]$Name, [string]$Exe, [string[]]$argList, [string]$WorkDir)
    if (-not (Test-Path $Exe)) { Die "executable not found: $Exe" }
    $out = Join-Path $RUNDIR ($Name + '.out.log')
    $err = Join-Path $RUNDIR ($Name + '.err.log')
    foreach ($f in @($out, $err)) {
        if ((Test-Path $f) -and ((Get-Item $f).Length -gt 20MB)) { Move-Item $f ($f + '.old') -Force }
    }
    $p = Start-Process -FilePath $Exe -ArgumentList $argList -WorkingDirectory $WorkDir `
                       -WindowStyle Hidden -PassThru -RedirectStandardOutput $out -RedirectStandardError $err
    Set-Content -Path (Join-Path $RUNDIR ($Name + '.pid')) -Value $p.Id -Encoding ASCII
    Say ("{0,-8} started  pid={1}  port={2}" -f $Name, $p.Id, (PortOf $Name))
}
# run "mysql.exe <options> [db] < file" through cmd so the redirect is byte exact
function Invoke-MySqlFile {
    param([string]$user, [string]$password, [string]$db, [string]$sqlFile, [string]$logFile)
    $tmp = Join-Path $RUNDIR 'tmp-mysql.cmd'
    $crlf = "`r`n"
    $body = '@echo off' + $crlf +
            'set "MYSQL_PWD=' + $password + '"' + $crlf +
            '"' + $exeMysql + '" --protocol=tcp -h 127.0.0.1 -P ' + $E['MYSQL_PORT'] +
            ' -u ' + $user + ' --default-character-set=utf8mb4'
    if ($db) { $body += ' ' + $db }
    $body += ' < "' + $sqlFile + '" > "' + $logFile + '" 2>&1' + $crlf + 'exit /b %ERRORLEVEL%' + $crlf
    [IO.File]::WriteAllText($tmp, $body, (New-Object Text.UTF8Encoding($false)))
    & cmd.exe @('/c', "`"$tmp`"") | Out-Null
    $rc = $LASTEXITCODE
    Remove-Item $tmp -Force -ErrorAction SilentlyContinue
    return $rc
}
# --------------------------------------------------------------------------- pre-flight
$script:PF_OK = 0; $script:PF_WARN = 0; $script:PF_FAIL = 0
function Pf {
    param([string]$lvl, [string]$msg)
    switch ($lvl) {
        'ok'    { $script:PF_OK++;   Write-Host ('  [ OK ]  ' + $msg) -ForegroundColor Green }
        'warn'  { $script:PF_WARN++; Write-Host ('  [WARN]  ' + $msg) -ForegroundColor Yellow }
        default { $script:PF_FAIL++; Write-Host ('  [FAIL]  ' + $msg) -ForegroundColor Red }
    }
}
function Rel([string]$p) {
    if ($p.StartsWith($PKG)) { return $p.Substring($PKG.Length).TrimStart('\') }
    return $p
}
# run a bundled binary with a harmless switch: proves the file is intact and that its own
# dependencies are satisfied (mysqld for example needs the Visual C++ runtime)
function Test-Binary([string]$exe, [string[]]$argList) {
    if (-not (Test-Path $exe)) { return $false }
    $prev = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    try { & $exe @argList 2>&1 | Out-Null; $rc = $LASTEXITCODE } catch { $rc = 1 }
    $ErrorActionPreference = $prev
    return ($rc -eq 0)
}
# read the major version out of "java -version": 25.0.4.1 -> 25, 1.8.0_504 -> 8, unknown -> 0
function Get-JavaMajor([string]$exe) {
    if (-not (Test-Path $exe)) { return 0 }
    $prev = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    try { $out = (& $exe '-version' 2>&1 | Out-String) } catch { $out = '' }
    $ErrorActionPreference = $prev
    if ($out -match 'version\s+"?(\d+)(?:\.(\d+))?') {
        $major = [int]$Matches[1]
        if ($major -eq 1 -and $Matches[2]) { return [int]$Matches[2] }   # 1.8.0_xxx -> 8
        return $major
    }
    return 0
}
function Do-Preflight {
    $script:PF_OK = 0; $script:PF_WARN = 0; $script:PF_FAIL = 0
    Write-Host ''
    Write-Host '=== pre-flight ==========================================================' -ForegroundColor Cyan

    # 1) every piece of the package must be there
    $want = [ordered]@{
        'mysql engine' = (Join-Path $MYSQL 'bin\mysqld.exe')
        'redis engine' = (Join-Path $REDIS 'redis-server.exe')
        'nginx'        = (Join-Path $NGX 'nginx.exe')
        'java runtime' = (Join-Path $JRE 'bin\java.exe')
        'backend jar'  = (Join-Path $BACKEND 'guanghe-server.jar')
        'web root'     = (Join-Path $NGX 'html\index.html')
        'config.bat'      = $envFile
        'engine'       = (Join-Path $PKG 'bin\gsite.ps1')
    }
    foreach ($t in @('my.ini.tpl', 'redis.conf.tpl', 'nginx.conf.tpl', 'application-deploy.yaml.tpl')) {
        $want.Add('template ' + $t, (Join-Path $TPLDIR $t))
    }
    foreach ($s in $SEED_SQL) {
        $want.Add('seed sql ' + $s, (Join-Path $SQLDIR $s))
    }
    $miss = 0
    foreach ($k in $want.Keys) {
        if (Test-Path $want[$k]) { Pf 'ok' ('{0,-24} {1}' -f $k, (Rel $want[$k])) }
        else { $miss++; Pf 'fail' ('{0,-24} missing: {1}' -f $k, (Rel $want[$k])) }
    }
    if ($miss -gt 0) { Pf 'fail' 'package is incomplete - re-copy the whole folder' }

    # 2) where the package was placed
    if ($PKG -match '[^\x20-\x7e]') {
        Pf 'warn' 'the path holds non ASCII characters - move the folder to a plain ASCII path if a service refuses to start'
    } elseif ($PKG -match ' ') {
        Pf 'warn' 'the path holds a space - quoting is handled, but a space free path is less risky'
    } else {
        Pf 'ok' ('package path is simple: ' + $PKG)
    }
    try {
        # $freeGB is a number: build the text in a double quoted string, "number + 'text'" would
        # make PowerShell convert the text to Double instead
        $q = Split-Path -Qualifier $PKG
        $freeGB = [Math]::Round(((New-Object IO.DriveInfo($q)).AvailableFreeSpace) / 1GB, 1)
        if ($freeGB -lt 1) { Pf 'fail' "only $freeGB GB free on $q - at least 1 GB is needed for data and logs" }
        elseif ($freeGB -lt 4) { Pf 'warn' "$freeGB GB free on $q - enough to start, watch the growth" }
        else { Pf 'ok' "$freeGB GB free on $q" }
    } catch { Pf 'warn' 'cannot read the free disk space' }

    # 3) what config.bat asks for
    $seen = @{}
    $bad = @()
    foreach ($k in @('WEB_PORT', 'BACKEND_PORT', 'MYSQL_PORT', 'REDIS_PORT')) {
        $v = [string]$E[$k]
        if ($v -notmatch '^\d+$' -or [int]$v -lt 1 -or [int]$v -gt 65535) { $bad += ($k + ' = ' + $v + ' is not a port'); continue }
        if ($seen.ContainsKey([int]$v)) { $bad += ($k + ' = ' + $v + ' collides with ' + $seen[[int]$v]) } else { $seen[[int]$v] = $k }
    }
    if ($bad.Count -gt 0) { foreach ($b in $bad) { Pf 'fail' ('config.bat: ' + $b) } }
    else {
        Pf 'ok' ('ports valid and distinct: web ' + $E['WEB_PORT'] + '  backend ' + $E['BACKEND_PORT'] + '  mysql ' + $E['MYSQL_PORT'] + '  redis ' + $E['REDIS_PORT'])
    }
    if ($E['SPRING_PROFILE'] -ne 'deploy') { Pf 'warn' ('SPRING_PROFILE = ' + $E['SPRING_PROFILE'] + ' - this package is built for the deploy profile') }
    if ($E['MYSQL_ROOT_PASSWORD'] -eq 'Gsite2026@Root' -or $E['MYSQL_APP_PASSWORD'] -eq 'Gsite2026@Data') {
        Pf 'warn' 'config.bat still has the shipped demo database passwords - change them before going live'
    }
    if ([string]$E['REDIS_PASSWORD'] -eq '') {
        Pf 'warn' ('redis has no password - keep it on 127.0.0.1 and never open port ' + $E['REDIS_PORT'] + ' to the network')
    }

    # 4) the bundled binaries must run on this OS
    if (Test-Binary $exeMysqld @('--no-defaults', '--version')) { Pf 'ok' 'mysqld runs here (C++ runtime is present)' }
    else { Pf 'fail' 'mysqld cannot run - Windows Server 2012 R2 / Windows 8.1 or newer is required (MySQL 8)' }
    if (Test-Binary (Join-Path $REDIS 'redis-server.exe') @('--version')) { Pf 'ok' 'redis-server runs here' }
    else { Pf 'fail' 'redis-server cannot run - bitness mismatch or a blocked download' }
    if (Test-Binary (Join-Path $JRE 'bin\java.exe') @('-version')) { Pf 'ok' 'the bundled java runs here' }
    else { Pf 'fail' 'java -version failed - the bundled jre is damaged, re-copy the package' }
    $jver = Get-JavaMajor (Join-Path $JRE 'bin\java.exe')
    if ($jver -ge $MIN_JAVA) {
        Pf 'ok' ("the bundled java is version {0} (>= {1} required by the backend jar)" -f $jver, $MIN_JAVA)
    } else {
        $shown = if ($jver -gt 0) { $jver } else { 'unknown' }
        Pf 'fail' ("the bundled jre is Java {0} but the backend jar needs Java {1}+ - replace jre\ with a Temurin {1} JRE (a full JDK {1} works as well)" -f $shown, $MIN_JAVA)
    }

    # 5) a port held by a program outside this package is a hard stop
    foreach ($c in @('mysql', 'redis', 'backend', 'nginx')) {
        $port = PortOf $c
        if (-not (Test-Port $port)) { Pf 'ok' ('port ' + $port + ' for ' + $c + ' is free'); continue }
        if (Test-PortOurs $port $c) { Pf 'ok' ('port ' + $port + ' for ' + $c + ' is already served by this package'); continue }
        $who = @()
        foreach ($owner in (PortOwnerPids $port)) {
            $o = ProcName $owner
            if ($o) { $who += ('' + $o.ProcessName + ' pid ' + $owner) } else { $who += ('pid ' + $owner) }
        }
        Pf 'fail' ('port ' + $port + ' for ' + $c + ' is taken by ' + (($who | Sort-Object -Unique) -join ', ') + ' - stop that program or change the port in config.bat')
    }

    # 6) the state the package is in right now
    if (Test-Path (Join-Path $MYSQL 'data\mysql')) {
        Pf 'ok' 'MySQL data directory is initialized - init keeps the existing data'
    } else {
        Pf 'warn' 'MySQL data directory is empty - init will create it and import the 3 sql\ seed scripts'
    }
    $pending = @($iniMysql, $confRedis, $confNginx, $cfgApp) | Where-Object { -not (Test-Path $_) }
    if ($pending.Count -gt 0) {
        Pf 'ok' ('configs generated from config.bat at start: ' + (($pending | ForEach-Object { Rel $_ }) -join ', '))
    } else {
        Pf 'ok' 'configs are rendered already - they are regenerated on every start'
    }

    Write-Host ('--------------------------------------------------------------------------------') -ForegroundColor Cyan
    Write-Host ('  ' + $script:PF_OK + ' ok   ' + $script:PF_WARN + ' warning(s)   ' + $script:PF_FAIL + ' failure(s)') -ForegroundColor Cyan
    if ($script:PF_FAIL -gt 0) {
        Write-Host '  fix every [FAIL] line first - ports live in config.bat' -ForegroundColor Red
        exit 1
    }
    Write-Host '  nothing blocks the initialization' -ForegroundColor Green
}

function Wait-MySql([int]$timeout) {
    $end = (Get-Date).AddSeconds($timeout)
    $tmp = Join-Path $RUNDIR 'tmp-ping.cmd'
    $outF = Join-Path $RUNDIR 'tmp-ping.out'
    $last = ''
    while ((Get-Date) -lt $end) {
        if (Test-Port ([int]$E['MYSQL_PORT'])) {
            # right after --initialize-insecure root still has no password, so an
            # "Access denied" answer is just as good as a successful ping
            $cmd = '@echo off' + "`r`n" + 'set "MYSQL_PWD=' + $E['MYSQL_ROOT_PASSWORD'] + '"' + "`r`n" +
                   '"' + $exeMysqlad + '" --protocol=tcp -h 127.0.0.1 -P ' + $E['MYSQL_PORT'] + ' -u root ping > "' + $outF + '" 2>&1' + "`r`n" +
                   'exit /b %ERRORLEVEL%' + "`r`n"
            [IO.File]::WriteAllText($tmp, $cmd, (New-Object Text.UTF8Encoding($false)))
            & cmd.exe @('/c', "`"$tmp`"") | Out-Null
            $rc = $LASTEXITCODE
            $answer = ''
            if (Test-Path $outF) { $answer = [IO.File]::ReadAllText($outF); Remove-Item $outF -Force -ErrorAction SilentlyContinue }
            Remove-Item $tmp -Force -ErrorAction SilentlyContinue
            if ($rc -eq 0) { return $true }
            if ($answer -match 'Access denied') { return $true }
            $last = ($answer -replace "`r|`n", ' ').Trim()
        } else { $last = 'port closed' }
        Start-Sleep -Seconds 1
    }
    Warn "mysql did not answer on port $($E['MYSQL_PORT']) within $timeout s (last: $last)"
    return $false
}

# --------------------------------------------------------------------------- render
function Do-Render {
    $map = @(
        @{ tpl = 'my.ini.tpl';                 out = $iniMysql },
        @{ tpl = 'redis.conf.tpl';             out = $confRedis },
        @{ tpl = 'nginx.conf.tpl';             out = $confNginx },
        @{ tpl = 'application-deploy.yaml.tpl'; out = $cfgApp }
    )
    foreach ($m in $map) {
        $src = Join-Path $TPLDIR $m.tpl
        if (-not (Test-Path $src)) { Die "template missing: $src" }
        $text = [IO.File]::ReadAllText($src)
        foreach ($k in $E.Keys) { $text = $text.Replace('@' + $k + '@', [string]$E[$k]) }
        $left = @([regex]::Matches($text, '@[A-Z][A-Z0-9_]*@') | ForEach-Object { $_.Value } | Sort-Object -Unique)
        if ($left.Count -gt 0) { Die ("unresolved placeholders in {0}: {1}" -f $m.tpl, ($left -join ' ')) }
        $dir = Split-Path -Parent $m.out
        if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
        $crlf = ($text -replace "`r`n", "`n") -replace "`n", "`r`n"
        [IO.File]::WriteAllText($m.out, $crlf, (New-Object Text.UTF8Encoding($false)))
        Say ("rendered {0}" -f (Fwd $m.out))
    }
}
function Require-Config {
    foreach ($f in @($iniMysql, $confRedis, $confNginx, $cfgApp)) {
        if (-not (Test-Path $f)) { Die "config not generated yet - run init.bat first (missing: $(Split-Path -Leaf $f))" }
    }
}

# --------------------------------------------------------------------------- components
function Start-MySQLProcess {
    Require-Config
    Assert-PortFreeOrOurs 'mysql'
    if (Test-Port ([int]$E['MYSQL_PORT'])) { Say 'mysql     already running - skip'; return }
    if (-not (Test-Path (Join-Path $MYSQL 'data\mysql'))) { Die 'mysql data dir not initialized - run init.bat first' }
    Start-Daemon 'mysql' $exeMysqld @("--defaults-file=$iniMysql") $MYSQL
    Wait-MySql 120 | Out-Null
}
function Stop-MySQLProcess {
    $port = [int]$E['MYSQL_PORT']
    if ((Test-Port $port) -and (Test-PortOurs $port 'mysql')) {
        $prev = $env:MYSQL_PWD
        $env:MYSQL_PWD = $E['MYSQL_ROOT_PASSWORD']
        & $exeMysqlad --protocol=tcp -h 127.0.0.1 -P $E['MYSQL_PORT'] -u root shutdown 2>$null | Out-Null
        $env:MYSQL_PWD = $prev
        NoLongerOnPort $port 'mysql' 20 | Out-Null
    }
    Stop-ByPid 'mysql'
    Remove-PidFile 'mysql'
}
function Start-RedisProcess {
    Require-Config
    Assert-PortFreeOrOurs 'redis'
    if (Test-Port ([int]$E['REDIS_PORT'])) { Say 'redis     already running - skip'; return }
    Start-Daemon 'redis' (Join-Path $REDIS 'redis-server.exe') @($confRedis) $REDIS
    Wait-Port ([int]$E['REDIS_PORT']) 'redis' 30 | Out-Null
}
function Stop-RedisProcess {
    $port = [int]$E['REDIS_PORT']
    if ((Test-Port $port) -and (Test-PortOurs $port 'redis')) {
        $prev = $env:REDISCLI_AUTH
        $env:REDISCLI_AUTH = $E['REDIS_PASSWORD']
        & (Join-Path $REDIS 'redis-cli.exe') @('-h', '127.0.0.1', '-p', $E['REDIS_PORT'], 'shutdown') 2>$null | Out-Null
        $env:REDISCLI_AUTH = $prev
        NoLongerOnPort $port 'redis' 15 | Out-Null
    }
    Stop-ByPid 'redis'
    Remove-PidFile 'redis'
}
function Start-BackendProcess {
    Require-Config
    Assert-PortFreeOrOurs 'backend'
    if (Test-Port ([int]$E['BACKEND_PORT'])) { Say 'backend   already running - skip'; return }
    # at boot time MySQL / Redis may still be coming up - wait for them before starting java
    if (-not (Wait-Port ([int]$E['MYSQL_PORT']) 'mysql' 300)) { Die 'backend not started: MySQL is not reachable' }
    if (-not (Wait-Port ([int]$E['REDIS_PORT']) 'redis' 300)) { Die 'backend not started: Redis is not reachable' }
    $java = Join-Path $JRE 'bin\java.exe'
    if (-not (Test-Path $java)) { Die "no java runtime found: $java" }
    $jver = Get-JavaMajor $java
    if ($jver -lt $MIN_JAVA) {
        $shown = if ($jver -gt 0) { $jver } else { 'unknown' }
        Die "the bundled java is Java $shown but the backend jar needs Java $MIN_JAVA+ - replace jre\ with a Temurin $MIN_JAVA JRE"
    }
    $jar = Join-Path $BACKEND 'guanghe-server.jar'
    if (-not (Test-Path $jar)) { Die "backend jar not found: $jar" }
    $argList = @(
        ('-Xms' + $E['JAVA_XMS']), ('-Xmx' + $E['JAVA_XMX']),
        '-Dfile.encoding=UTF-8', '-Duser.timezone=Asia/Shanghai',
        '-XX:+HeapDumpOnOutOfMemoryError', '-XX:HeapDumpPath=./logs',
        '-jar', 'guanghe-server.jar',
        ('--spring.profiles.active=' + $E['SPRING_PROFILE']),
        ('--server.port=' + $E['BACKEND_PORT']),
        '--spring.config.additional-location=file:./config/'
    )
    Start-Daemon 'backend' $java $argList $BACKEND
    Wait-Port ([int]$E['BACKEND_PORT']) 'backend' 240 | Out-Null
}
function Stop-BackendProcess {
    Stop-ByPid 'backend'
    NoLongerOnPort ([int]$E['BACKEND_PORT']) 'backend' 20 | Out-Null
}
function Start-NginxProcess {
    Require-Config
    Assert-PortFreeOrOurs 'nginx'
    if (Test-Port ([int]$E['WEB_PORT'])) { Say 'nginx     already running - skip'; return }
    Start-Daemon 'nginx' (Join-Path $NGX 'nginx.exe') @('-p', $NGX, '-c', 'conf\nginx.conf') $NGX
    Start-Sleep -Milliseconds 1500
    if (-not (Test-Port ([int]$E['WEB_PORT']))) {
        Get-Content (Join-Path $NGX 'logs\error.log') -Tail 12 -ErrorAction SilentlyContinue | Write-Host
        Die "nginx is not listening on $($E['WEB_PORT']) - see nginx\logs\error.log"
    }
}
function Stop-NginxProcess {
    if (Test-Path (Join-Path $NGX 'logs\nginx.pid')) {
        & (Join-Path $NGX 'nginx.exe') @('-p', $NGX, '-c', 'conf\nginx.conf', '-s', 'quit') 2>$null | Out-Null
        NoLongerOnPort ([int]$E['WEB_PORT']) 'nginx' 10 | Out-Null
    }
    Stop-ByPid 'nginx'
}

$order = @('mysql', 'redis', 'backend', 'nginx')
function Components([string]$c) {
    if ($c -eq 'all') { return $order }
    if ($c -eq 'app') { return @('backend', 'nginx') }
    if ($order -contains $c) { return , @($c) }
    Die "unknown component: $c (use mysql|redis|backend|nginx|app|all)"
}
function Do-Launch([string[]]$list) {
    Do-Render   # so that a boot task always uses the current config.bat
    foreach ($c in $list) {
        switch ($c) {
            'mysql'   { Start-MySQLProcess }
            'redis'   { Start-RedisProcess }
            'backend' { Start-BackendProcess }
            'nginx'   { Start-NginxProcess }
        }
    }
}
function Do-Start([string[]]$list) {
    # configs are re-rendered from config.bat on every start, so an edit there takes effect at once
    Do-Render
    foreach ($c in $list) {
        switch ($c) {
            'mysql' {
                if (Test-Service $MYSQL_NAME) { Say "mysql     -> net start $MYSQL_NAME"; & net.exe @('start', $MYSQL_NAME) | Out-Null; Wait-MySql 120 | Out-Null }
                else { Start-MySQLProcess }
            }
            'redis' {
                if (Test-Service $REDIS_NAME) { Say "redis     -> net start $REDIS_NAME"; & net.exe @('start', $REDIS_NAME) | Out-Null }
                elseif (Test-Task $REDIS_NAME) { Say "redis     -> schtasks /run $REDIS_NAME"; & schtasks.exe @('/run', '/tn', $REDIS_NAME) | Out-Null; Wait-Port ([int]$E['REDIS_PORT']) 'redis' 60 | Out-Null }
                else { Start-RedisProcess }
            }
            'backend' {
                if (Test-Task $APP_TASK) { Say "backend   -> schtasks /run $APP_TASK (starts backend + nginx)"; & schtasks.exe @('/run', '/tn', $APP_TASK) | Out-Null; break }
                Start-BackendProcess
            }
            'nginx' {
                if (Test-Task $APP_TASK) { Say "nginx     -> handled by task $APP_TASK"; break }
                Start-NginxProcess
            }
        }
    }
    Write-Host ''
    Show-Status
}
function Do-Stop([string[]]$list) {
    $rev = @($list)
    [array]::Reverse($rev)
    foreach ($c in $rev) {
        switch ($c) {
            'nginx'   { Stop-NginxProcess }
            'backend' {
                if (Test-Task $APP_TASK) { & schtasks.exe @('/end', '/tn', $APP_TASK) 2>$null | Out-Null }
                Stop-BackendProcess
            }
            'redis'   {
                if (Test-Service $REDIS_NAME) { & net.exe @('stop', $REDIS_NAME) | Out-Null } else { Stop-RedisProcess }
            }
            'mysql'   {
                if (Test-Service $MYSQL_NAME) { & net.exe @('stop', $MYSQL_NAME) | Out-Null } else { Stop-MySQLProcess }
            }
        }
    }
}
function Show-Status {
    Write-Host ''
    Write-Host ("{0,-9} {1,-22} {2,-9} {3,-7} {4}" -f 'COMPONENT', 'SERVICE/TASK', 'PID', 'PORT', 'STATE')
    Write-Host ('-' * 68)
    foreach ($c in $order) {
        $svc = '-'
        if ($c -eq 'mysql' -and (Test-Service $MYSQL_NAME)) { $svc = $MYSQL_NAME }
        if ($c -eq 'redis') {
            if (Test-Service $REDIS_NAME) { $svc = $REDIS_NAME } elseif (Test-Task $REDIS_NAME) { $svc = $REDIS_NAME + ' (task)' }
        }
        if (($c -eq 'backend' -or $c -eq 'nginx') -and (Test-Task $APP_TASK)) { $svc = $APP_TASK + ' (task)' }
        $p = PidOfFile $c
        $port = PortOf $c
        $st = if (Test-Port $port) { 'LISTENING' } else { 'stopped' }
        Write-Host ("{0,-9} {1,-22} {2,-9} {3,-7} {4}" -f $c, $svc, $(if ($p) { $p } else { '-' }), $port, $st)
    }
    Write-Host ''
    Write-Host ("  admin UI   http://127.0.0.1:{0}/" -f $E['WEB_PORT'])
    Write-Host ("  backend    127.0.0.1:{0} (bound to loopback on purpose)" -f $E['BACKEND_PORT'])
    Write-Host ("  mysql      127.0.0.1:{0}  db={1} app user={2}" -f $E['MYSQL_PORT'], $E['MYSQL_DB'], $E['MYSQL_APP_USER'])
    Write-Host ("  redis      127.0.0.1:{0}" -f $E['REDIS_PORT'])
    Write-Host ''
}
function Do-Health {
    $bad = @()
    foreach ($c in $order) { if (-not (Test-Port (PortOf $c))) { $bad += $c } }
    if ($bad.Count -eq 0) { Say 'health OK - mysql / redis / backend / nginx are listening'; return }
    Die ("health FAIL - not listening: " + ($bad -join ', '))
}

# --------------------------------------------------------------------------- setup (init)
function Do-Init {
    Do-Render
    $dataDir = Join-Path $MYSQL 'data'
    $fresh = $Force -or (-not (Test-Path (Join-Path $dataDir 'mysql')))
    if ($fresh) {
        if ($Force) { Stop-MySQLProcess }   # nothing may hold the files we are about to erase
        $stray = @(Get-ChildItem $dataDir -Force -ErrorAction SilentlyContinue | Where-Object { $_.Name -ne '.keep' })
        if ($stray.Count -gt 0) {
            if (-not $Force) {
                Die "mysql\data exists but is not a MySQL data directory - rerun: init.bat -force (ERASES the current database)"
            }
            if (-not $dataDir.StartsWith($MYSQL, [StringComparison]::OrdinalIgnoreCase)) {
                Die "refusing to erase an unexpected directory: $dataDir"
            }
            Say 'erasing the existing MySQL data directory (-force) ...'
            Remove-Item (Join-Path $dataDir '*') -Recurse -Force -ErrorAction SilentlyContinue
            $stray = @(Get-ChildItem $dataDir -Force -ErrorAction SilentlyContinue | Where-Object { $_.Name -ne '.keep' })
            if ($stray.Count -gt 0) { Die 'cannot empty mysql\data - close the programs using it and retry' }
        }
        if (-not (Test-Path $dataDir)) { New-Item -ItemType Directory -Path $dataDir | Out-Null }
        # mysqld insists on a completely empty datadir; .keep only exists to ship the folder
        Remove-Item (Join-Path $dataDir '.keep') -Force -ErrorAction SilentlyContinue
        Say 'initializing the MySQL data directory ...'
        & $exeMysqld @("--defaults-file=$iniMysql", '--initialize-insecure') 2>&1 |
            ForEach-Object { "$_" } | Set-Content (Join-Path $LOGDIR 'init-mysql.log') -Encoding ASCII
        if (-not (Test-Path (Join-Path $dataDir 'mysql'))) {
            Get-Content (Join-Path $MYSQL 'logs\mysqld.err') -Tail 20 -ErrorAction SilentlyContinue | Write-Host
            Die 'MySQL init failed - see logs\init-mysql.log and mysql\logs\mysqld.err'
        }
        Say 'MySQL data directory created (root password is empty for now)'
    } else {
        Say 'MySQL data directory already exists - skip init'
    }

    $startedHere = $false
    # never send the account SQL below to a MySQL that this package does not own
    Assert-PortFreeOrOurs 'mysql'
    if (-not (Test-Port ([int]$E['MYSQL_PORT']))) {
        Start-MySQLProcess
        if (-not (Wait-MySql 150)) { Die 'MySQL is not usable - see mysql\logs\mysqld.err' }
        $startedHere = $true
    }

    $db = $E['MYSQL_DB']
    if ($db -notmatch '^[A-Za-z0-9_]+$') { Die "MYSQL_DB may only contain letters, digits and '_' (got: $db)" }
    foreach ($u in @($E['MYSQL_APP_USER'])) {
        if ($u -notmatch '^[A-Za-z0-9_]+$') { Die "MYSQL_APP_USER may only contain letters, digits and '_' (got: $u)" }
    }

    # accounts + schema: works both for a fresh (no password) and an already secured server
    $initSql = Join-Path $RUNDIR 'init-db.sql'
    $rp = $E['MYSQL_ROOT_PASSWORD']; $ap = $E['MYSQL_APP_PASSWORD']; $au = $E['MYSQL_APP_USER']
    $body = @"
ALTER USER 'root'@'localhost' IDENTIFIED BY '$rp';
CREATE USER IF NOT EXISTS 'root'@'127.0.0.1' IDENTIFIED BY '$rp';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1' WITH GRANT OPTION;
CREATE DATABASE IF NOT EXISTS ``$db`` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '$au'@'localhost' IDENTIFIED BY '$ap';
CREATE USER IF NOT EXISTS '$au'@'127.0.0.1' IDENTIFIED BY '$ap';
GRANT ALL PRIVILEGES ON ``$db``.* TO '$au'@'localhost';
GRANT ALL PRIVILEGES ON ``$db``.* TO '$au'@'127.0.0.1';
FLUSH PRIVILEGES;
"@
    [IO.File]::WriteAllText($initSql, ($body -replace "`r`n", "`n" -replace "`n", "`r`n"), (New-Object Text.UTF8Encoding($false)))

    # no database selected: it is created by this very script
    $rc = Invoke-MySqlFile 'root' '' '' $initSql (Join-Path $LOGDIR 'init-db.log')
    if ($rc -ne 0) {
        $rc = Invoke-MySqlFile 'root' $rp '' $initSql (Join-Path $LOGDIR 'init-db.log')
        if ($rc -ne 0) { Get-Content (Join-Path $LOGDIR 'init-db.log') | Write-Host; Die 'cannot create the database / users in MySQL' }
    }
    Say "database '$db' and accounts are ready"

    # import the seed only when the schema is still empty
    $prev = $env:MYSQL_PWD
    $env:MYSQL_PWD = $rp
    $cnt = (& $exeMysql @('--protocol=tcp', '-h', '127.0.0.1', '-P', $E['MYSQL_PORT'], '-u', 'root', '-N', '-B', '-e', "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='$db'") 2>$null | Out-String).Trim()
    if ($LASTEXITCODE -ne 0 -or $cnt -eq '') { $cnt = '0' }
    if ([int]$cnt -gt 0 -and -not $Force) {
        Say "database '$db' already has $cnt table(s) - seed import skipped (rerun with: init.bat -force)"
    } else {
        if ($Force -and [int]$cnt -gt 0) {
            Say "dropping and recreating '$db' (-force) ..."
            & $exeMysql @('--protocol=tcp', '-h', '127.0.0.1', '-P', $E['MYSQL_PORT'], '-u', 'root', '-e', "DROP DATABASE IF EXISTS ``$db``; CREATE DATABASE ``$db`` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;") 2>$null | Out-Null
        }
        $seeds = $SEED_SQL
        foreach ($s in $seeds) {
            if (-not (Test-Path (Join-Path $SQLDIR $s))) { Die "seed not found: $SQLDIR\$s" }
        }
        foreach ($s in $seeds) {
            Say "importing sql\$s into '$db' (utf8mb4) ..."
            $irc = Invoke-MySqlFile 'root' $rp $db (Join-Path $SQLDIR $s) (Join-Path $LOGDIR "import-$s.log")
            if ($irc -ne 0) {
                Get-Content (Join-Path $LOGDIR "import-$s.log") -Tail 20 | Write-Host
                Die "seed import reported errors: $s"
            }
        }
        $cnt2 = (& $exeMysql @('--protocol=tcp', '-h', '127.0.0.1', '-P', $E['MYSQL_PORT'], '-u', 'root', '-N', '-B', '-e', "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='$db'") 2>$null | Out-String).Trim()
        Say "seed imported, table count = $cnt2"
    }
    $env:MYSQL_PWD = $prev

    if ($startedHere) { Say 'stopping the temporary MySQL instance ...'; Stop-MySQLProcess }
    Write-Host ''
    Say 'initialization finished - next: start-all.bat   (or install-service.bat for boot start)'
}

# --------------------------------------------------------------------------- services
function Do-InstallService {
    if (-not (Test-Admin)) { Die 'install-service.bat must be run as Administrator (right click -> Run as administrator)' }
    Do-Render
    if (-not (Test-Path (Join-Path $MYSQL 'data\mysql'))) { Die 'MySQL is not initialized - run init.bat first' }

    if (Test-Service $MYSQL_NAME) {
        Say "service $MYSQL_NAME already installed"
    } else {
        Say "installing the MySQL service: $MYSQL_NAME ..."
        & $exeMysqld @('--install', $MYSQL_NAME, "--defaults-file=$iniMysql") | Out-Null
        if (-not (Test-Service $MYSQL_NAME)) { Die 'mysqld --install failed' }
        Say "service $MYSQL_NAME installed (start type: auto)"
    }

    $rs = Join-Path $REDIS 'redis-server.exe'
    if (Test-Service $REDIS_NAME) {
        Say "service $REDIS_NAME already installed"
    } else {
        Say "installing the Redis service: $REDIS_NAME ..."
        & $rs @("--service-install", "`"$confRedis`"", '--service-name', $REDIS_NAME) 2>&1 | ForEach-Object { "$_" }
        if (Test-Service $REDIS_NAME) {
            Say "service $REDIS_NAME installed (start type: auto)"
        } else {
            Warn 'this Redis build has no Windows service support - using a boot task instead'
            if (Test-Task $REDIS_NAME) { & schtasks.exe @('/delete', '/tn', $REDIS_NAME, '/f') | Out-Null }
            & schtasks.exe @('/create', '/tn', $REDIS_NAME, '/tr', "`"$(Join-Path $PSScriptRoot 'svc-redis.bat')`"", '/sc', 'onstart', '/ru', 'SYSTEM', '/rl', 'highest', '/f') | Out-Null
            if ($LASTEXITCODE -ne 0) { Die "schtasks /create failed for $REDIS_NAME" }
            Say "boot task $REDIS_NAME created"
        }
    }

    $bat = Join-Path $PSScriptRoot 'svc-app.bat'
    if (Test-Task $APP_TASK) { & schtasks.exe @('/delete', '/tn', $APP_TASK, '/f') | Out-Null }
    Say "creating the boot task: $APP_TASK (backend + nginx) ..."
    & schtasks.exe @('/create', '/tn', $APP_TASK, '/tr', "`"$bat`"", '/sc', 'onstart', '/ru', 'SYSTEM', '/rl', 'highest', '/f') | Out-Null
    if ($LASTEXITCODE -ne 0) { Die "schtasks /create failed for $APP_TASK" }

    Write-Host ''
    Say 'registered. They start automatically after a reboot.'
    Say 'to start them right now:  start-all.bat'
}
function Do-UninstallService {
    if (-not (Test-Admin)) { Die 'uninstall-service.bat must be run as Administrator' }
    Do-Stop $order
    if (Test-Task $APP_TASK) { & schtasks.exe @('/delete', '/tn', $APP_TASK, '/f') | Out-Null; Say "task $APP_TASK removed" }
    if (Test-Task $REDIS_NAME) { & schtasks.exe @('/delete', '/tn', $REDIS_NAME, '/f') | Out-Null; Say "task $REDIS_NAME removed" }
    if (Test-Service $REDIS_NAME) {
        & (Join-Path $REDIS 'redis-server.exe') @('--service-uninstall', '--service-name', $REDIS_NAME) 2>&1 | ForEach-Object { "$_" }
        if (Test-Service $REDIS_NAME) { & sc.exe @('delete', $REDIS_NAME) | Out-Null }
        Say "service $REDIS_NAME removed"
    }
    if (Test-Service $MYSQL_NAME) {
        & $exeMysqld @('--remove', $MYSQL_NAME) 2>&1 | ForEach-Object { "$_" }
        if (Test-Service $MYSQL_NAME) { & sc.exe @('delete', $MYSQL_NAME) | Out-Null }
        Say "service $MYSQL_NAME removed"
    }
    Say 'done - data and logs were NOT deleted'
}

# --------------------------------------------------------------------------- dispatch
switch ($Action) {
    'render'            { Do-Render }
    'preflight'         { Do-Preflight }
    'init'              { Do-Init }
    'launch'            { Do-Launch (Components $Component) }
    'start'             { Do-Start (Components $Component) }
    'stop'              { Do-Stop (Components $Component) }
    'restart'           { Do-Stop (Components $Component); Start-Sleep -Seconds 2; Do-Start (Components $Component) }
    'status'            { Show-Status }
    'health'            { Do-Health }
    'install-service'   { Do-InstallService }
    'uninstall-service' { Do-UninstallService }
    default             { Die "unknown action: $Action" }
}
exit 0
