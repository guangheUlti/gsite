@echo off
rem ===========================================================================
rem  ONE TIME initialization of this package.
rem  An existing database is never erased, so this file is safe to run again.
rem
rem    init.bat               pre-flight check, then render configs + create the
rem                           MySQL data directory + create the accounts + import
rem                           the 3 sql\*.sql scripts   (the same engine call that
rem                           setup.bat makes)
rem    init.bat -start        the above, then start the whole stack right away
rem    init.bat -force -yes   ERASE the data directory and the database 'gsite'
rem                           and re-import the 3 sql\*.sql from scratch
rem
rem  Day to day control afterwards: start-all.bat / stop-all.bat / restart-all.bat
rem  Everything is configurable in config.bat only.
rem ===========================================================================
setlocal
title GSite init
cd /d "%~dp0"

set EXTRA=
set WANTSTART=
set WANTFORCE=
set HAVEYES=
for %%A in (%*) do (
  if /i "%%~A"=="-force" set WANTFORCE=1
  if /i "%%~A"=="-start" set WANTSTART=1
  if /i "%%~A"=="-yes"   set HAVEYES=1
)

if not defined WANTFORCE goto :checkenv
if defined HAVEYES goto :forceok
echo.
echo   [!] init.bat -force DESTROYS data: the MySQL data directory and the
echo       database 'gsite' are erased and re-imported from sql\*.sql.
echo       Confirm it with:  init.bat -force -yes
echo       Plain  init.bat  keeps the current data and only fills what is missing.
exit /b 2
:forceok
set EXTRA=-Force

:checkenv
if exist "%~dp0config.bat" goto :go
echo.
echo   [FAIL] config.bat not found next to this script - the package is incomplete,
echo          copy the whole gsite-deploy folder again.
pause
exit /b 1

:go
echo.
echo  package : %~dp0
echo.
echo ===================== 1/3  pre-flight =========================
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0bin\gsite.ps1" -Action preflight
if not "%ERRORLEVEL%"=="0" goto :fail

echo.
echo ===================== 2/3  initialize =========================
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0bin\gsite.ps1" -Action init %EXTRA%
if not "%ERRORLEVEL%"=="0" goto :fail

echo.
echo ===================== 3/3  verify =============================
if exist "%~dp0mysql\data\mysql" goto :datadir
echo   [FAIL] the MySQL data directory was not created
goto :fail
:datadir
echo   [ OK ]  MySQL data directory and database are in place
echo   [ OK ]  configs generated: mysql\my.ini, redis\redis.conf,
echo           nginx\conf\nginx.conf, backend\config\application-deploy.yaml

set WEBPORT=80
for /f "tokens=2 delims==" %%A in ('findstr /b /c:"set WEB_PORT=" "%~dp0config.bat"') do set WEBPORT=%%A

if not defined WANTSTART goto :nostart
echo.
echo ===================== start ==================================
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0bin\gsite.ps1" -Action start
if not "%ERRORLEVEL%"=="0" goto :fail
echo.
echo   open  http://127.0.0.1:%WEBPORT%/
goto :done

:nostart
echo.
echo   next step: start-all.bat        (or use  init.bat -start  next time)
echo.
echo   [OK] initialization finished
pause
exit /b 0

:done
echo.
echo   [OK] initialization finished and the stack is up
pause
exit /b 0

:fail
echo.
echo   [FAIL] initialization stopped - fix the [FAIL] lines above and run init.bat again
echo          logs: logs\, mysql\logs\, run\
pause
exit /b 1
