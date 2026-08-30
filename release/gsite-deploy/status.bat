@echo off
setlocal
title GSite status
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0bin\gsite.ps1" -Action status
echo.
pause
exit /b 0