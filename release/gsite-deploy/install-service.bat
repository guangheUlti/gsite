@echo off
rem ===========================================================================
rem  Registers the package so that it survives a reboot:
rem    <prefix>-MySQL : Windows service, start type auto   (mysqld --install)
rem    <prefix>-Redis : Windows service when the build supports it,
rem                     otherwise a boot task
rem    <prefix>-App   : boot task running backend + nginx as SYSTEM
rem  Run it from an elevated prompt ("Run as administrator").
rem  <prefix> comes from SERVICE_PREFIX in config.bat (default GSite).
rem ===========================================================================
setlocal
title GSite install service
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0bin\gsite.ps1" -Action install-service
set RC=%ERRORLEVEL%
echo.
if not "%RC%"=="0" echo   [FAIL] install-service returned %RC%
pause
exit /b %RC%