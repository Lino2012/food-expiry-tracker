@echo off
title Food Expiry Tracker - Stop Script
echo Stopping Food Expiry Tracker...
call mvn jetty:stop -f pom.xml
echo.
echo Server stopped.
pause
