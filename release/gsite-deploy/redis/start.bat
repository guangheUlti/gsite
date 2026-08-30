@echo off
setlocal
title GSite Redis start
cd /d "%~dp0.."
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0..\bin\gsite.ps1" -Action start -Component redis
set RC=%ERRORLEVEL%
echo.
if not "%RC%"=="0" echo   [FAIL] Redis start returned %RC%
pause
exit /b %RC%
