<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 - Server Error | Food Expiry Tracker</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <main style="min-height: 100vh; display: flex; align-items: center; justify-content: center;">
        <div class="glass-card" style="text-align: center; max-width: 500px;">
            <div style="font-size: 6rem; margin-bottom: 1rem;">&#9888;&#65039;</div>
            <h1 style="font-size: 4rem; margin-bottom: 0.5rem;">500</h1>
            <h2>Internal Server Error</h2>
            <p style="color: #666; margin-bottom: 2rem;">
                Something went wrong on our end. Please try again later.
            </p>
            <div style="display: flex; gap: 1rem; justify-content: center;">
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go Home</a>
                <a href="javascript:location.reload()" class="btn btn-secondary">Try Again</a>
            </div>
        </div>
    </main>
</body>
</html>
