@echo off
rem removes the services / boot task created by install-service.bat
rem data (mysql\data, redis\dump.rdb, logs) are NOT touched
setlocal
title GSite uninstall service
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0bin\gsite.ps1" -Action uninstall-service
set RC=%ERRORLEVEL%
echo.
if not "%RC%"=="0" echo   [FAIL] uninstall-service returned %RC%
pause
exit /b %RC%