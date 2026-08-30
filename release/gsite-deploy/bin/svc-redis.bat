@echo off
rem fallback boot task for Redis, used when the Redis build has no service support
cd /d "%~dp0.."
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0gsite.ps1" -Action launch -Component redis
exit /b %ERRORLEVEL%