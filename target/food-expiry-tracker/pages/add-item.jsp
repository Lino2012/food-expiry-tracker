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
    <meta name="description" content="Add a new food item to track its expiry date">
    <title>Add Food Item | Food Expiry Tracker</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <c:import url="/components/navbar.jsp"/>
    
    <main class="main-content">
        <div class="container">
            <div class="add-item-page">
                <div class="glass-card" style="max-width: 600px; margin: 0 auto;">
                    <h2>Add New Food Item</h2>
                    <p style="color: #666; margin-bottom: 2rem;">
                        Enter the details of your food item below
                    </p>
                    
                    <form id="addItemForm">
                        <div class="form-group">
                            <label class="form-label" for="itemName">Food Name *</label>
                            <input type="text" 
                                   class="form-control" 
                                   id="itemName" 
                                   name="name" 
                                   required 
                                   placeholder="e.g., Organic Milk">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="category">Category</label>
                            <select class="form-control" id="category" name="category">
                                <option value="">Select Category</option>
                                <option value="Dairy">Dairy</option>
                                <option value="Meat">Meat</option>
                                <option value="Vegetables">Vegetables</option>
                                <option value="Fruits">Fruits</option>
                                <option value="Bakery">Bakery</option>
                                <option value="Pantry">Pantry</option>
                                <option value="Frozen">Frozen</option>
                                <option value="Beverages">Beverages</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="expiryDate">Expiry Date *</label>
                            <input type="date" 
                                   class="form-control" 
                                   id="expiryDate" 
                                   name="expiryDate" 
                                   required>
                        </div>
                        
                        <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 1rem;">
                            <div class="form-group">
                                <label class="form-label" for="quantity">Quantity *</label>
                                <input type="number" 
                                       class="form-control" 
                                       id="quantity" 
                                       name="quantity" 
                                       min="1" 
                                       value="1" 
                                       required>
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label" for="unit">Unit</label>
                                <select class="form-control" id="unit" name="unit">
                                    <option value="pieces">Pieces</option>
                                    <option value="grams">Grams</option>
                                    <option value="kg">Kilograms</option>
                                    <option value="ml">Milliliters</option>
                                    <option value="liters">Liters</option>
                                    <option value="pack">Pack</option>
                                    <option value="box">Box</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="notes">Notes (Optional)</label>
                            <textarea class="form-control" 
                                      id="notes" 
                                      name="notes" 
                                      rows="3" 
                                      placeholder="Add any additional notes..."></textarea>
                        </div>
                        
                        <div style="display: flex; gap: 1rem; margin-top: 2rem;">
                            <button type="submit" class="btn btn-primary">
                                Add Item
                            </button>
                            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary">
                                Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>
    
    <c:import url="/components/footer.jsp"/>
    
    <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>