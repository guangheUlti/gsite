@echo off
rem ===========================================================================
rem  GSite deploy package - single configuration source
rem ---------------------------------------------------------------------------
rem  This is the ONLY file you normally have to edit on a new server.
rem  All scripts in this folder (and all config templates under templates\)
rem  take their values from here.
rem
rem  After changing anything here, run:  setup.bat   (first time only)
rem  Every start re-renders mysql\my.ini, redis\redis.conf, nginx\conf\nginx.conf
rem  and backend\config\application-deploy.yaml from these values, so a plain
rem  restart-all.bat is enough after later edits.
rem
rem  Password values: use letters, digits and @ # _ only.
rem  Avoid & | < > ^ % " and ' - they break .bat parsing.
rem ===========================================================================

rem ---- HTTP entry point (nginx, this is the port users open in the browser) ----
set WEB_PORT=80

rem ---- backend (Spring Boot, always bound to 127.0.0.1 - reached through nginx) ----
set BACKEND_PORT=48080
set SPRING_PROFILE=deploy
set JAVA_XMS=1024m
set JAVA_XMX=2048m

rem ---- MySQL ----
set MYSQL_PORT=3306
set MYSQL_DB=gsite
set MYSQL_ROOT_PASSWORD=Gsite2026@Root
set MYSQL_APP_USER=gsite
set MYSQL_APP_PASSWORD=Gsite2026@Data
set MYSQL_BIND_ADDRESS=127.0.0.1
set MYSQL_MAX_CONNECTIONS=500
set MYSQL_INNODB_BUFFER_POOL=512M

rem ---- Redis ----
set REDIS_PORT=6379
rem leave empty to disable the password (redis binds to 127.0.0.1 anyway)
set REDIS_PASSWORD=
set REDIS_MAXMEMORY=512mb

rem ---- name prefix of the Windows services / boot tasks ----
set SERVICE_PREFIX=GSite
