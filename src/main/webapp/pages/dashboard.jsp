<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="/pages/login.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Dashboard - Track your food expiry dates at a glance">
    <title>Dashboard | Food Expiry Tracker</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <c:import url="/components/navbar.jsp"/>
    
    <main class="main-content">
        <div class="container">
            <div class="dashboard-page">
                <!-- Welcome Section -->
                <div class="glass-card" style="margin-bottom: 2rem;">
                    <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
                        <div>
                            <h1>Welcome back, ${sessionScope.user.fullName}!</h1>
                            <p style="color: #666;">Here's your food expiry overview</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/pages/add-item.jsp" class="btn btn-primary">
                            + Add New Item
                        </a>
                    </div>
                </div>
                
                <!-- Statistics Cards -->
                <div class="dashboard-container">
                    <div class="stat-card">
                        <div class="stat-icon">&#128230;</div>
                        <div class="stat-value" id="totalItems">0</div>
                        <div class="stat-label">Total Items</div>
                    </div>
                    
                    <div class="stat-card" style="--card-color: #CC0000;">
                        <div class="stat-icon">&#9888;&#65039;</div>
                        <div class="stat-value" id="expiredItems">0</div>
                        <div class="stat-label">Expired</div>
                    </div>
                    
                    <div class="stat-card" style="--card-color: #E65100;">
                        <div class="stat-icon">&#9200;</div>
                        <div class="stat-value" id="expiringSoon">0</div>
                        <div class="stat-label">Expiring Soon</div>
                    </div>
                    
                    <div class="stat-card" style="--card-color: #2E7D32;">
                        <div class="stat-icon">&#9989;</div>
                        <div class="stat-value" id="safeItems">0</div>
                        <div class="stat-label">Fresh Items</div>
                    </div>
                </div>
                
                <!-- Search and Filter -->
                <div class="glass-card" style="margin: 2rem 0;">
                    <div class="search-container">
                        <div class="search-wrapper">
                            <span class="search-icon">&#128269;</span>
                            <input type="text" 
                                   id="searchInput" 
                                   class="search-input" 
                                   placeholder="Search food items...">
                        </div>
                        
                        <select id="filterSelect" class="filter-select">
                            <option value="ALL">All Items</option>
                            <option value="EXPIRED">Expired</option>
                            <option value="EXPIRING">Expiring Soon</option>
                            <option value="SAFE">Fresh</option>
                        </select>
                    </div>
                </div>
                
                <!-- Food Items Grid -->
                <h2 style="margin-bottom: 1rem;">Your Food Items</h2>
                <div id="foodItemsContainer" class="food-grid">
                    <!-- Items loaded dynamically via JS -->
                </div>
            </div>
        </div>
    </main>
    
    <c:import url="/components/footer.jsp"/>
    
    <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>