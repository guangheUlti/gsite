@echo off
setlocal
title GSite Redis stop
cd /d "%~dp0.."
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0..\bin\gsite.ps1" -Action stop -Component redis
set RC=%ERRORLEVEL%
echo.
if not "%RC%"=="0" echo   [FAIL] Redis stop returned %RC%
pause
exit /b %RC%
