@echo off
title Food Expiry Tracker - Docker Startup
echo Starting Food Expiry Tracker via Docker...
docker-compose up -d --build
echo.
echo Application is starting at http://localhost:8080
echo Use 'docker-compose logs -f' to see logs.
pause
