@echo off
setlocal
title GSite stop
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0bin\gsite.ps1" -Action stop
set RC=%ERRORLEVEL%
echo.
if not "%RC%"=="0" echo   [FAIL] stop returned %RC%
pause
exit /b %RC%