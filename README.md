# 🍎 Food Expiry Tracker

A premium, luxury-grade SaaS application designed to help households reduce food waste and save money by tracking expiry dates with style and precision.

![Premium UI](https://img.shields.io/badge/UI-Luxury_Red_&_White-red)
![Backend](https://img.shields.io/badge/Backend-Java_Servlet_&_JSP-blue)
![Database](https://img.shields.io/badge/Database-MySQL_8.0-orange)
![DevOps](https://img.shields.io/badge/DevOps-Docker_&_Jenkins-blueviolet)

## ✨ Core Features

- **💎 Luxury UI/UX**: Stunning Glassmorphism design with a premium red/white aesthetic.
- **📊 Smart Dashboard**: Real-time analytics showing Total, Expired, Expiring Soon, and Fresh items.
- **📦 Inventory Management**: Easily add, view, search, and delete food items.
- **⏰ Intelligence**: Automatic calculation of days remaining with color-coded status badges.
- **📱 Responsive**: Optimized for Desktop, Tablet, and Mobile devices.
- **🔐 Secure**: Password hashing with BCrypt and session-based authentication.

## 🛠️ Technology Stack

- **Core**: Java 11+, Servlet 4.0, JSP, JSTL
- **Database**: MySQL 8.0 (with optimized Views for analytics)
- **Frontend**: Vanilla JS (ES6+), CSS3 (Modern Design Tokens), Google Fonts (Inter)
- **Build & DevOps**: 
  - Maven (Build & Dependency Management)
  - Jetty 9.4 (Optimized Local Server)
  - Docker & Docker Compose (Containerization)
  - Jenkins (CI/CD Pipeline)
  - JUnit 4 & Mockito (Unit Testing)

## 🚀 Getting Started

### 1. Prerequisites
- **Java 11 or 17**
- **Maven 3.8+**
- **MySQL 8.0** (running on port 3306)

### 2. Database Setup
Execute the provided SQL schema to initialize the database:
```powershell
# Using the automation script (Windows)
Get-Content sql/schema.sql | mysql -u root -p
```
*Note: Ensure your MySQL `root` password matches `root123` or update `src/main/resources/application.properties`.*

### 3. Running Locally (Windows)
I have provided one-click scripts for your convenience:
- **`run.bat`**: Cleans, builds, and launches the application on **http://localhost:8081/food-expiry-tracker/**.
- **`stop.bat`**: Gracefully stops the local server.

### 4. Docker Deployment
If you have Docker installed:
```bash
docker-compose up -d --build
```
The application will be available at **http://localhost:8080**.

## 🧪 Testing
The project includes a comprehensive suite of JUnit tests for the service layer and date utilities.
```bash
mvn test
```

## 📂 Project Structure
```text
food-expiry-tracker/
├── src/main/java/          # Java Source Code (Servlet, Service, Repo)
├── src/main/webapp/        # JSP, CSS, JS, and Images
├── src/test/java/          # JUnit Test Cases
├── sql/                    # Database Schema and Views
├── Dockerfile              # Container Configuration
├── docker-compose.yml      # Multi-container Orchestration
├── Jenkinsfile             # CI/CD Pipeline Definitions
├── pom.xml                 # Maven Project Configuration
└── run.bat                 # One-click Windows Startup
```

## 📜 License
Crafted with ❤️ for a waste-free world.