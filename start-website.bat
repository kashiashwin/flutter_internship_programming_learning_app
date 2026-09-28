@echo off
title INOVIQ Website Launcher
echo ========================================================
echo   Launching INOVIQ Programming Learning Web Platform...
echo ========================================================
echo.
echo Starting local web server at http://localhost:3000
start "" "http://localhost:3000"
python -m http.server 3000 --directory website
pause
