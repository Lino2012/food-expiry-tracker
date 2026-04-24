<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<footer class="footer">
    <div class="footer-container">
        <div class="footer-grid">
            <div class="footer-brand">
                <div class="brand-wrap">
                    <span class="footer-logo">🍎</span>
                    <span class="footer-name">FoodExpiry</span>
                </div>
                <p>The ultimate smart food management system for modern households.</p>
            </div>
            <div class="footer-links">
                <h4>Product</h4>
                <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
                <a href="${pageContext.request.contextPath}/pages/view-items.jsp">Inventory</a>
                <a href="${pageContext.request.contextPath}/pages/add-item.jsp">Add Item</a>
            </div>
            <div class="footer-links">
                <h4>Support</h4>
                <a href="#">Help Center</a>
                <a href="#">Privacy Policy</a>
                <a href="#">Terms of Service</a>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2024 FoodExpiry Tracker. Crafted with ❤️ for a waste-free world.</p>
        </div>
    </div>
</footer>

<style>
.footer {
    background: white;
    border-top: 1px solid var(--gray-100);
    padding: 4rem 0 2rem;
    margin-top: 6rem;
}

.footer-grid {
    display: grid;
    grid-template-columns: 2fr 1fr 1fr;
    gap: 4rem;
    margin-bottom: 3rem;
    text-align: left;
}

.brand-wrap {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    margin-bottom: 1rem;
}

.footer-logo { font-size: 1.5rem; }
.footer-name { 
    font-weight: 800; 
    font-size: 1.25rem; 
    color: var(--primary-red);
}

.footer-brand p {
    color: var(--gray-600);
    max-width: 300px;
    font-size: 0.9rem;
}

.footer-links h4 {
    margin-bottom: 1.25rem;
    font-size: 1rem;
    color: var(--text-dark);
}

.footer-links a {
    display: block;
    color: var(--gray-600);
    text-decoration: none;
    margin-bottom: 0.75rem;
    font-size: 0.9rem;
    transition: color 0.2s;
}

.footer-links a:hover {
    color: var(--primary-red);
}

.footer-bottom {
    padding-top: 2rem;
    border-top: 1px solid var(--gray-100);
    color: var(--gray-500);
    font-size: 0.85rem;
}

@media (max-width: 768px) {
    .footer-grid { grid-template-columns: 1fr; gap: 2rem; text-align: center; }
    .brand-wrap { justify-content: center; }
    .footer-brand p { margin: 0 auto; }
}
</style>