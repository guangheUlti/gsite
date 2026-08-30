# ===========================================================================
# Redis configuration of the GSite deploy package
# generated from templates\redis.conf.tpl by gsite.ps1 - edit config.bat instead
# Redis 3.0 on Windows: no protected-mode / no daemonize, the process is kept
# in the foreground and supervised by gsite.ps1 (or by the Windows service).
# ===========================================================================

# only this machine may connect; the backend runs on the same host
bind 127.0.0.1
port @REDIS_PORT@
timeout 0
tcp-keepalive 60
databases 16

# ---- persistence ----
dir "@REDIS_DIR@"
dbfilename dump.rdb
save 900 1
save 300 10
save 60 10000
rdbcompression yes
appendonly no

# ---- memory ----
maxmemory @REDIS_MAXMEMORY@
# only keys that carry a TTL may be evicted: caches in this project always do,
# while distributed locks / stream data would be dangerous to drop silently
maxmemory-policy volatile-lru

# ---- auth ----
@REDIS_REQUIREPASS@

# ---- logging (file inside redis\logs) ----
logfile "logs/redis.log"
loglevel notice

# ---- client limits ----
maxclients 10000
