@echo off
setlocal
title GSite MySQL stop
cd /d "%~dp0.."
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0..\bin\gsite.ps1" -Action stop -Component mysql
set RC=%ERRORLEVEL%
echo.
if not "%RC%"=="0" echo   [FAIL] MySQL stop returned %RC%
pause
exit /b %RC%
