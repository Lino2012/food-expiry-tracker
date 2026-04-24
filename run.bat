@echo off
setlocal
title Food Expiry Tracker - Startup Script

echo ===================================================
echo   🍎 Food Expiry Tracker - Production Ready 🍎
echo ===================================================
echo.

:: Check if Maven is installed
where mvn >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Maven (mvn) is not found in your PATH. 
    echo Please install Maven and try again.
    pause
    exit /b 1
)

echo [1/3] Cleaning and building the project...
call mvn clean install -DskipTests -f pom.xml

if %ERRORLEVEL% neq 0 (
    echo.
    echo [ERROR] Build failed. Please check the logs above.
    pause
    exit /b 1
)

echo.
echo [2/3] Build successful! 🚀
echo.
echo [3/3] Starting the application server on http://localhost:8081/food-expiry-tracker
echo      (Press Ctrl+C to stop the server at any time)
echo.

:: Set JVM flags for Java 11+ compatibility with Jetty/Tomcat plugins
set MAVEN_OPTS=--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED --add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED --add-opens=java.base/java.util=ALL-UNNAMED

:: Start Jetty
call mvn jetty:run -f pom.xml

pause
