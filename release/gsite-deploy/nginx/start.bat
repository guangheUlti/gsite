@echo off
setlocal
title GSite Nginx start
cd /d "%~dp0.."
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0..\bin\gsite.ps1" -Action start -Component nginx
set RC=%ERRORLEVEL%
echo.
if not "%RC%"=="0" echo   [FAIL] Nginx start returned %RC%
pause
exit /b %RC%
