@echo off
echo Starting Food Expiry Tracker Database Setup...
docker-compose down
docker-compose up -d mysql
echo Waiting for MySQL to be ready...
timeout /t 15 /nobreak
echo Database is ready!
docker-compose logs mysql