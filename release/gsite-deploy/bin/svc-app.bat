@echo off
rem started by the boot task <prefix>-App: backend + nginx
cd /d "%~dp0.."
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0gsite.ps1" -Action launch -Component app
exit /b %ERRORLEVEL%