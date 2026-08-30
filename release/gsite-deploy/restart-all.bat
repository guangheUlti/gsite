@echo off
setlocal
title GSite restart
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0bin\gsite.ps1" -Action restart
set RC=%ERRORLEVEL%
echo.
if not "%RC%"=="0" echo   [FAIL] restart returned %RC%
pause
exit /b %RC%