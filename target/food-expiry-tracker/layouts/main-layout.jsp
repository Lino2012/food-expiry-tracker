<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Food Expiry Tracker - Premium food management system">
    <title>${param.title} | Food Expiry Tracker</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <c:import url="/components/navbar.jsp"/>
    
    <main class="main-content">
        <div class="container">
            ${param.content}
        </div>
    </main>
    
    <c:import url="/components/footer.jsp"/>
    
    <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
