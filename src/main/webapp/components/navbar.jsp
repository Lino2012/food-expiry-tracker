<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar">
    <div class="navbar-container">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">
            <span class="brand-icon">🍎</span>
            <span class="brand-text">Foodine</span>
        </a>
        
        <div class="navbar-menu">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/dashboard" class="navbar-link">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/pages/view-items.jsp" class="navbar-link">My Items</a>
                    <a href="${pageContext.request.contextPath}/pages/add-item.jsp" class="btn btn-primary btn-sm">
                        <span>+</span> Add Item
                    </a>
                    <div class="user-profile">
                        <div class="user-avatar">
                            ${sessionScope.user.fullName.substring(0,1)}
                        </div>
                        <div class="user-dropdown">
                            <div class="user-info">
                                <strong>${sessionScope.user.fullName}</strong>
                                <span>${sessionScope.user.email}</span>
                            </div>
                            <hr>
                            <a href="${pageContext.request.contextPath}/auth/logout" class="logout-link">
                                <span>Logout</span>
                            </a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/pages/login.jsp" class="navbar-link">Login</a>
                    <a href="${pageContext.request.contextPath}/pages/register.jsp" class="btn btn-primary">
                        Get Started
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

<style>
.user-profile {
    position: relative;
    margin-left: 1rem;
    cursor: pointer;
}

.user-avatar {
    width: 36px;
    height: 36px;
    background: var(--primary-red);
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 700;
    box-shadow: var(--shadow-sm);
    transition: transform var(--transition-fast);
}

.user-profile:hover .user-avatar {
    transform: scale(1.05);
}

.user-dropdown {
    position: absolute;
    top: calc(100% + 10px);
    right: 0;
    width: 200px;
    background: white;
    border-radius: var(--radius-md);
    box-shadow: var(--shadow-lg);
    padding: 1rem;
    display: none;
    z-index: 1001;
    border: 1px solid var(--glass-border);
}

.user-profile:hover .user-dropdown {
    display: block;
    animation: fadeInUp 0.2s ease-out;
}

.user-info {
    display: flex;
    flex-direction: column;
    margin-bottom: 0.5rem;
}

.user-info strong {
    font-size: 0.9rem;
    color: var(--text-dark);
}

.user-info span {
    font-size: 0.75rem;
    color: var(--gray-600);
}

.user-dropdown hr {
    border: 0;
    border-top: 1px solid var(--gray-100);
    margin: 0.5rem 0;
}

.logout-link {
    display: block;
    color: var(--primary-red);
    text-decoration: none;
    font-size: 0.85rem;
    font-weight: 600;
    padding: 0.25rem 0;
}

.logout-link:hover {
    text-decoration: underline;
}

.brand-icon {
    font-size: 1.5rem;
}

.brand-text {
    background: linear-gradient(135deg, var(--primary-red), var(--dark-red));
    -webkit-background-clip: text;
    background-clip: text;
    color: transparent;
    font-weight: 800;
    letter-spacing: -0.5px;
}
</style>