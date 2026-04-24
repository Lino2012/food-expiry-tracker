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
    <meta name="description" content="View and manage all your tracked food items">
    <title>My Food Items | Food Expiry Tracker</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <c:import url="/components/navbar.jsp"/>
    
    <main class="main-content">
        <div class="container">
            <div class="view-items-page">
                <div class="glass-card" style="margin-bottom: 2rem;">
                    <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
                        <div>
                            <h1>My Food Items</h1>
                            <p style="color: #666;">Manage and track all your food items</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/pages/add-item.jsp" class="btn btn-primary">
                            + Add New Item
                        </a>
                    </div>
                </div>
                
                <!-- Search and Filter -->
                <div class="glass-card" style="margin-bottom: 2rem;">
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
