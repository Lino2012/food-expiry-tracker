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
    <meta name="description" content="Create your Food Expiry Tracker account - start reducing food waste today">
    <title>Register | Food Expiry Tracker</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <c:import url="/components/navbar.jsp"/>
    
    <main style="min-height: calc(100vh - 200px); display: flex; align-items: center; justify-content: center;">
        <div class="glass-card" style="width: 100%; max-width: 450px;">
            <div style="text-align: center; margin-bottom: 2rem;">
                <div style="font-size: 3rem; margin-bottom: 1rem;">🥗</div>
                <h2>Create Account</h2>
                <p style="color: #666;">Start tracking your food expiry dates today</p>
            </div>
            
            <form id="registerForm">
                <div class="form-group">
                    <label class="form-label" for="fullName">Full Name</label>
                    <input type="text" 
                           class="form-control" 
                           id="fullName" 
                           name="fullName" 
                           required 
                           placeholder="Enter your full name">
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="email">Email</label>
                    <input type="email" 
                           class="form-control" 
                           id="email" 
                           name="email" 
                           required 
                           placeholder="your@email.com">
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="reg-username">Username</label>
                    <input type="text" 
                           class="form-control" 
                           id="reg-username" 
                           name="username" 
                           required 
                           placeholder="Choose a username">
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="reg-password">Password</label>
                    <input type="password" 
                           class="form-control" 
                           id="reg-password" 
                           name="password" 
                           required 
                           placeholder="Create a password"
                           minlength="6">
                    <small style="color: #666; margin-top: 0.25rem; display: block;">
                        Password must be at least 6 characters
                    </small>
                </div>
                
                <button type="submit" class="btn btn-primary" style="width: 100%;">
                    Create Account
                </button>
                
                <div style="text-align: center; margin-top: 1.5rem;">
                    <p style="color: #666;">
                        Already have an account? 
                        <a href="${pageContext.request.contextPath}/pages/login.jsp" 
                           style="color: var(--primary-red); text-decoration: none; font-weight: 600;">
                            Sign In
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