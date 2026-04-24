<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${not empty sessionScope.user}">
    <c:redirect url="/dashboard"/>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Sign in to Food Expiry Tracker - manage your food expiry dates">
    <title>Login | Food Expiry Tracker</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <c:import url="/components/navbar.jsp"/>
    
    <main style="min-height: calc(100vh - 200px); display: flex; align-items: center; justify-content: center;">
        <div class="glass-card" style="width: 100%; max-width: 450px;">
            <div style="text-align: center; margin-bottom: 2rem;">
                <div style="font-size: 3rem; margin-bottom: 1rem;">🍎</div>
                <h2>Welcome Back</h2>
                <p style="color: #666;">Sign in to continue tracking your food items</p>
            </div>
            
            <form id="loginForm">
                <div class="form-group">
                    <label class="form-label" for="username">Username or Email</label>
                    <input type="text" 
                           class="form-control" 
                           id="username" 
                           name="username" 
                           required 
                           placeholder="Enter your username or email">
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="password">Password</label>
                    <input type="password" 
                           class="form-control" 
                           id="password" 
                           name="password" 
                           required 
                           placeholder="Enter your password">
                </div>
                
                <button type="submit" class="btn btn-primary" style="width: 100%;">
                    Sign In
                </button>
                
                <div style="text-align: center; margin-top: 1.5rem;">
                    <p style="color: #666;">
                        Don't have an account? 
                        <a href="${pageContext.request.contextPath}/pages/register.jsp" 
                           style="color: var(--primary-red); text-decoration: none; font-weight: 600;">
                            Create Account
                        </a>
                    </p>
                </div>
            </form>
        </div>
    </main>
    
    <c:import url="/components/footer.jsp"/>
    
    <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>