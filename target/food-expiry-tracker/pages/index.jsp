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
    <meta name="description" content="Food Expiry Tracker - The ultimate SaaS platform to manage your kitchen inventory and reduce food waste.">
    <title>FoodExpiry | Smart Food Management</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="landing-page">
    <c:import url="/components/navbar.jsp"/>
    
    <header class="hero-section">
        <div class="container">
            <div class="hero-content">
                <div class="hero-text">
                    <span class="hero-badge">Smart Kitchen Revolution</span>
                    <h1>Manage Your Food <br><span class="text-gradient">Before It's Too Late</span></h1>
                    <p>Stop throwing money in the bin. Our intelligent tracking system monitors your inventory and alerts you before items expire.</p>
                    <div class="hero-actions">
                        <a href="${pageContext.request.contextPath}/pages/register.jsp" class="btn btn-primary btn-lg">Get Started Free</a>
                        <a href="#features" class="btn btn-secondary btn-lg">Learn More</a>
                    </div>
                    <div class="hero-stats">
                        <div class="hero-stat-item">
                            <strong>10k+</strong>
                            <span>Active Users</span>
                        </div>
                        <div class="hero-stat-divider"></div>
                        <div class="hero-stat-item">
                            <strong>$500</strong>
                            <span>Avg. Annual Savings</span>
                        </div>
                    </div>
                </div>
                <div class="hero-visual">
                    <div class="hero-card-stack">
                        <div class="glass-card hero-preview-card">
                            <div class="preview-header">
                                <span class="preview-emoji">🍎</span>
                                <div class="preview-info">
                                    <strong>Organic Milk</strong>
                                    <span>Dairy • 1 Liter</span>
                                </div>
                                <span class="badge badge-expiring">Expiring Soon</span>
                            </div>
                            <div class="preview-progress">
                                <div class="progress-bar" style="width: 85%;"></div>
                            </div>
                            <div class="preview-footer">
                                <span>2 days remaining</span>
                            </div>
                        </div>
                        <div class="glass-card hero-preview-card offset">
                            <div class="preview-header">
                                <span class="preview-emoji">🥗</span>
                                <div class="preview-info">
                                    <strong>Fresh Salad</strong>
                                    <span>Vegetables • 2 Packs</span>
                                </div>
                                <span class="badge badge-safe">Fresh</span>
                            </div>
                            <div class="preview-progress">
                                <div class="progress-bar" style="width: 30%;"></div>
                            </div>
                            <div class="preview-footer">
                                <span>6 days remaining</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <section id="features" class="features-section">
        <div class="container">
            <div class="section-header">
                <h2>Why Choose FoodExpiry?</h2>
                <p>Built for busy people who care about their wallet and the planet.</p>
            </div>
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">🚀</div>
                    <h3>Fast Input</h3>
                    <p>Add items in seconds with our streamlined interface and smart category detection.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🔔</div>
                    <h3>Smart Alerts</h3>
                    <p>Receive timely notifications on your dashboard so you never miss an expiry date.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">📊</div>
                    <h3>Waste Analytics</h3>
                    <p>Visualize your consumption patterns and see how much you're saving over time.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="cta-section">
        <div class="container">
            <div class="glass-card cta-card">
                <h2>Ready to reduce your food waste?</h2>
                <p>Join thousands of smart households today. No credit card required.</p>
                <a href="${pageContext.request.contextPath}/pages/register.jsp" class="btn btn-primary btn-lg">Create Your Free Account</a>
            </div>
        </div>
    </section>
    
    <c:import url="/components/footer.jsp"/>

    <style>
        .hero-section {
            padding: 6rem 0;
            overflow: hidden;
        }
        .hero-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 4rem;
            align-items: center;
        }
        .hero-badge {
            display: inline-block;
            padding: 0.5rem 1rem;
            background: var(--light-red);
            color: var(--primary-red);
            border-radius: var(--radius-full);
            font-size: 0.85rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .text-gradient {
            background: linear-gradient(135deg, var(--primary-red), var(--accent-red));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }
        .hero-text p {
            font-size: 1.25rem;
            color: var(--gray-600);
            margin-bottom: 2.5rem;
            max-width: 500px;
        }
        .hero-actions {
            display: flex;
            gap: 1rem;
            margin-bottom: 3rem;
        }
        .hero-stats {
            display: flex;
            align-items: center;
            gap: 2rem;
        }
        .hero-stat-item strong {
            display: block;
            font-size: 1.5rem;
            color: var(--text-dark);
        }
        .hero-stat-item span {
            font-size: 0.85rem;
            color: var(--gray-600);
        }
        .hero-stat-divider {
            width: 1px;
            height: 30px;
            background: var(--gray-200);
        }
        .hero-visual {
            position: relative;
        }
        .hero-card-stack {
            position: relative;
            height: 300px;
        }
        .hero-preview-card {
            position: absolute;
            width: 100%;
            max-width: 400px;
            padding: 1.5rem;
        }
        .hero-preview-card.offset {
            top: 80px;
            left: 60px;
            z-index: 2;
        }
        .preview-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }
        .preview-emoji {
            font-size: 2rem;
        }
        .preview-info {
            flex: 1;
        }
        .preview-info strong {
            display: block;
            font-size: 1rem;
        }
        .preview-info span {
            font-size: 0.75rem;
            color: var(--gray-600);
        }
        .preview-progress {
            height: 6px;
            background: var(--gray-100);
            border-radius: 3px;
            margin-bottom: 0.5rem;
            overflow: hidden;
        }
        .progress-bar {
            height: 100%;
            background: var(--primary-red);
            border-radius: 3px;
        }
        .preview-footer {
            font-size: 0.8rem;
            color: var(--gray-500);
            text-align: right;
        }
        .features-section {
            padding: 6rem 0;
            background: var(--gray-50);
        }
        .section-header {
            text-align: center;
            margin-bottom: 4rem;
        }
        .features-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 2rem;
        }
        .feature-card {
            background: white;
            padding: 2.5rem;
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-sm);
            transition: transform 0.3s ease;
        }
        .feature-card:hover {
            transform: translateY(-10px);
        }
        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 1.5rem;
        }
        .cta-section {
            padding: 6rem 0;
            text-align: center;
        }
        .cta-card {
            padding: 4rem;
            background: linear-gradient(135deg, var(--primary-red), var(--dark-red));
            color: white;
        }
        .cta-card h2 { color: white; margin-bottom: 1rem; }
        .cta-card p { margin-bottom: 2.5rem; opacity: 0.9; font-size: 1.1rem; }
        .btn-lg { padding: 1rem 2.5rem; font-size: 1.1rem; }

        @media (max-width: 992px) {
            .hero-content { grid-template-columns: 1fr; text-align: center; }
            .hero-text p { margin-left: auto; margin-right: auto; }
            .hero-actions { justify-content: center; }
            .hero-stats { justify-content: center; }
            .hero-visual { display: none; }
            .features-grid { grid-template-columns: 1fr; }
        }
    </style>
</body>
</html>