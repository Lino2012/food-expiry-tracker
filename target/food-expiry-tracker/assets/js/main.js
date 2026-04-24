// Premium Food Expiry Tracker - Main JavaScript
const FoodExpiryTracker = {
    API: {
        BASE_URL: (function() {
            // Auto-detect context path from current page URL
            const path = window.location.pathname;
            const contextEnd = path.indexOf('/', 1);
            if (contextEnd > 0) {
                return window.location.origin + path.substring(0, contextEnd);
            }
            return window.location.origin;
        })(),
        FOOD: '/food',
        AUTH: '/auth'
    },
    
    init() {
        this.setupEventListeners();
        this.loadDashboardStats();
        this.loadFoodItems();
        this.setupAnimations();
    },
    
    setupEventListeners() {
        // Search functionality
        const searchInput = document.getElementById('searchInput');
        if (searchInput) {
            searchInput.addEventListener('input', this.debounce(() => {
                this.searchFoodItems(searchInput.value);
            }, 300));
        }
        
        // Filter functionality
        const filterSelect = document.getElementById('filterSelect');
        if (filterSelect) {
            filterSelect.addEventListener('change', () => {
                this.filterFoodItems(filterSelect.value);
            });
        }
        
        // Form submissions
        const addItemForm = document.getElementById('addItemForm');
        if (addItemForm) {
            addItemForm.addEventListener('submit', (e) => {
                e.preventDefault();
                this.addFoodItem(new FormData(addItemForm));
            });
        }
        
        const loginForm = document.getElementById('loginForm');
        if (loginForm) {
            loginForm.addEventListener('submit', (e) => {
                e.preventDefault();
                this.login(new FormData(loginForm));
            });
        }
        
        const registerForm = document.getElementById('registerForm');
        if (registerForm) {
            registerForm.addEventListener('submit', (e) => {
                e.preventDefault();
                this.register(new FormData(registerForm));
            });
        }
    },
    
    async loadDashboardStats() {
        try {
            const response = await fetch(this.API.BASE_URL + this.API.FOOD + '/stats');
            if (!response.ok) return;
            const stats = await response.json();
            
            this.updateDashboardUI(stats);
        } catch (error) {
            console.log('Dashboard stats not available on this page');
        }
    },
    
    updateDashboardUI(stats) {
        const elements = {
            totalItems: document.getElementById('totalItems'),
            expiredItems: document.getElementById('expiredItems'),
            expiringSoon: document.getElementById('expiringSoon'),
            safeItems: document.getElementById('safeItems')
        };
        
        if (elements.totalItems) {
            this.animateValue(elements.totalItems, 0, stats.totalItems || 0, 1000);
        }
        if (elements.expiredItems) {
            this.animateValue(elements.expiredItems, 0, stats.expiredItems || 0, 1000);
        }
        if (elements.expiringSoon) {
            this.animateValue(elements.expiringSoon, 0, stats.expiringSoon || 0, 1000);
        }
        if (elements.safeItems) {
            this.animateValue(elements.safeItems, 0, stats.safeItems || 0, 1000);
        }
    },
    
    animateValue(element, start, end, duration) {
        if (end === start) {
            element.textContent = end;
            return;
        }
        const range = end - start;
        const increment = range / (duration / 16);
        let current = start;
        
        const animate = () => {
            current += increment;
            if ((increment > 0 && current >= end) || (increment < 0 && current <= end)) {
                element.textContent = Math.round(end);
                return;
            }
            element.textContent = Math.round(current);
            requestAnimationFrame(animate);
        };
        
        animate();
    },
    
    async loadFoodItems() {
        const container = document.getElementById('foodItemsContainer');
        if (!container) return;
        
        this.showLoading(container);
        
        try {
            const response = await fetch(this.API.BASE_URL + this.API.FOOD + '/list');
            if (!response.ok) {
                if (response.status === 401) return;
                throw new Error('Failed to load');
            }
            const items = await response.json();
            
            this.renderFoodItems(items, container);
        } catch (error) {
            console.error('Failed to load food items:', error);
            this.showError('Failed to load food items', container);
        }
    },
    
    renderFoodItems(items, container) {
        if (!items || items.length === 0) {
            container.innerHTML = this.getEmptyStateHTML();
            return;
        }
        
        const html = items.map((item, index) => this.getFoodCardHTML(item, index)).join('');
        container.innerHTML = html;
        
        // Add delete event listeners
        container.querySelectorAll('.delete-item').forEach(btn => {
            btn.addEventListener('click', () => this.deleteFoodItem(btn.dataset.id));
        });
    },
    
    getFoodCardHTML(item, index) {
        const statusClass = this.getStatusClass(item.expiryStatus);
        const statusText = this.getStatusText(item.expiryStatus);
        const daysText = this.getDaysText(item.daysUntilExpiry);
        const categoryIcon = this.getCategoryIcon(item.category);
        const delay = (index || 0) * 0.08;
        
        return `
            <div class="food-card" data-id="${item.id}" style="animation-delay: ${delay}s;">
                <div class="food-header">
                    <div>
                        <div class="food-name">${categoryIcon} ${this.escapeHtml(item.name)}</div>
                        <div class="food-category">${this.escapeHtml(item.category || 'Uncategorized')}</div>
                    </div>
                    <span class="badge ${statusClass}">${statusText}</span>
                </div>
                <div class="food-details">
                    <div class="food-detail-row">
                        <span class="food-detail-label">Quantity</span>
                        <span class="food-detail-value">${item.quantity} ${this.escapeHtml(item.unit || 'units')}</span>
                    </div>
                    ${item.notes ? `
                    <div class="food-detail-row">
                        <span class="food-detail-label">Notes</span>
                        <span class="food-detail-value">${this.escapeHtml(item.notes)}</span>
                    </div>` : ''}
                </div>
                <div class="food-expiry">
                    <span class="expiry-text">&#128197; ${daysText}</span>
                    <button class="btn btn-danger btn-sm delete-item" data-id="${item.id}" title="Remove item">
                        &#128465; Remove
                    </button>
                </div>
            </div>
        `;
    },
    
    getCategoryIcon(category) {
        const icons = {
            'Dairy': '&#129472;',
            'Meat': '&#129385;',
            'Vegetables': '&#129382;',
            'Fruits': '&#127823;',
            'Bakery': '&#127838;',
            'Pantry': '&#129776;',
            'Frozen': '&#129482;',
            'Beverages': '&#129380;',
            'Other': '&#127869;'
        };
        return icons[category] || '&#127869;';
    },
    
    async searchFoodItems(keyword) {
        const container = document.getElementById('foodItemsContainer');
        if (!container) return;
        
        this.showLoading(container);
        
        try {
            const url = keyword 
                ? `${this.API.BASE_URL}${this.API.FOOD}/search?q=${encodeURIComponent(keyword)}`
                : `${this.API.BASE_URL}${this.API.FOOD}/list`;
                
            const response = await fetch(url);
            const items = await response.json();
            
            this.renderFoodItems(items, container);
        } catch (error) {
            console.error('Search failed:', error);
            this.showError('Search failed', container);
        }
    },
    
    async filterFoodItems(status) {
        const container = document.getElementById('foodItemsContainer');
        if (!container) return;
        
        this.showLoading(container);
        
        try {
            const url = `${this.API.BASE_URL}${this.API.FOOD}/search?status=${status}`;
            const response = await fetch(url);
            const items = await response.json();
            
            this.renderFoodItems(items, container);
        } catch (error) {
            console.error('Filter failed:', error);
            this.showError('Filter failed', container);
        }
    },
    
    async addFoodItem(formData) {
        const data = {
            name: formData.get('name'),
            category: formData.get('category'),
            expiryDate: formData.get('expiryDate'),
            quantity: parseInt(formData.get('quantity')),
            unit: formData.get('unit'),
            notes: formData.get('notes')
        };
        
        try {
            const response = await fetch(this.API.BASE_URL + this.API.FOOD, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            });
            
            const result = await response.json();
            
            if (result.success) {
                this.showSuccess('Food item added successfully! Redirecting...');
                setTimeout(() => {
                    window.location.href = this.API.BASE_URL + '/dashboard';
                }, 1000);
            } else {
                this.showError(result.message || 'Failed to add item');
            }
        } catch (error) {
            console.error('Failed to add item:', error);
            this.showError('Failed to add food item');
        }
    },
    
    async deleteFoodItem(id) {
        if (!confirm('Are you sure you want to remove this item?')) {
            return;
        }
        
        try {
            const response = await fetch(`${this.API.BASE_URL}${this.API.FOOD}/${id}`, {
                method: 'DELETE'
            });
            
            const result = await response.json();
            
            if (result.success) {
                this.showSuccess('Item removed successfully');
                // Animate the card out before refreshing
                const card = document.querySelector(`.food-card[data-id="${id}"]`);
                if (card) {
                    card.style.transition = 'all 0.4s ease';
                    card.style.transform = 'scale(0.8)';
                    card.style.opacity = '0';
                    setTimeout(() => {
                        this.loadFoodItems();
                        this.loadDashboardStats();
                    }, 400);
                } else {
                    this.loadFoodItems();
                    this.loadDashboardStats();
                }
            } else {
                this.showError(result.message || 'Failed to remove item');
            }
        } catch (error) {
            console.error('Failed to delete item:', error);
            this.showError('Failed to remove food item');
        }
    },
    
    async login(formData) {
        const data = {
            username: formData.get('username'),
            password: formData.get('password')
        };
        
        const btn = document.querySelector('#loginForm button[type="submit"]');
        if (btn) {
            btn.disabled = true;
            btn.textContent = 'Signing in...';
        }
        
        try {
            const response = await fetch(this.API.BASE_URL + this.API.AUTH + '/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            });
            
            const result = await response.json();
            
            if (result.success) {
                this.showSuccess('Login successful! Redirecting...');
                // Use the redirect URL from server, or fallback to dashboard
                window.location.href = result.redirect || (this.API.BASE_URL + '/dashboard');
            } else {
                this.showError(result.message || 'Invalid username or password');
            }
        } catch (error) {
            console.error('Login failed:', error);
            this.showError('Login failed. Please check your connection and try again.');
        } finally {
            if (btn) {
                btn.disabled = false;
                btn.textContent = 'Sign In';
            }
        }
    },
    
    async register(formData) {
        const data = {
            username: formData.get('username'),
            email: formData.get('email'),
            password: formData.get('password'),
            fullName: formData.get('fullName')
        };
        
        const btn = document.querySelector('#registerForm button[type="submit"]');
        if (btn) {
            btn.disabled = true;
            btn.textContent = 'Creating account...';
        }
        
        try {
            const response = await fetch(this.API.BASE_URL + this.API.AUTH + '/register', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            });
            
            const result = await response.json();
            
            if (result.success) {
                this.showSuccess('Registration successful! Redirecting to login...');
                setTimeout(() => {
                    window.location.href = this.API.BASE_URL + '/pages/login.jsp';
                }, 1500);
            } else {
                this.showError(result.message || 'Registration failed');
            }
        } catch (error) {
            console.error('Registration failed:', error);
            this.showError('Registration failed. Please try again.');
        } finally {
            if (btn) {
                btn.disabled = false;
                btn.textContent = 'Create Account';
            }
        }
    },
    
    setupAnimations() {
        // Intersection Observer for scroll-triggered animations
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animate-in');
                    observer.unobserve(entry.target);
                }
            });
        }, { threshold: 0.1 });
        
        document.querySelectorAll('.glass-card, .stat-card').forEach(el => {
            observer.observe(el);
        });
    },
    
    // Utility functions
    debounce(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    },
    
    escapeHtml(text) {
        if (!text) return '';
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    },
    
    getStatusClass(status) {
        const classes = {
            'EXPIRED': 'badge-expired',
            'EXPIRING': 'badge-expiring',
            'SAFE': 'badge-safe'
        };
        return classes[status] || 'badge-default';
    },
    
    getStatusText(status) {
        const texts = {
            'EXPIRED': 'Expired',
            'EXPIRING': 'Expiring Soon',
            'SAFE': 'Fresh'
        };
        return texts[status] || status;
    },
    
    getDaysText(days) {
        if (days < 0) {
            return `Expired ${Math.abs(days)} day${Math.abs(days) !== 1 ? 's' : ''} ago`;
        } else if (days === 0) {
            return 'Expires today';
        } else {
            return `Expires in ${days} day${days !== 1 ? 's' : ''}`;
        }
    },
    
    showLoading(container) {
        container.innerHTML = `
            <div class="loading" style="grid-column: 1 / -1;">
                <div class="loading-spinner"></div>
            </div>
        `;
    },
    
    showError(message, container = null) {
        if (container) {
            container.innerHTML = `
                <div class="empty-state" style="grid-column: 1 / -1;">
                    <div class="empty-state-icon">&#10060;</div>
                    <h3>Error</h3>
                    <p>${message}</p>
                </div>
            `;
        } else {
            this.showToast(message, 'error');
        }
    },
    
    showSuccess(message) {
        this.showToast(message, 'success');
    },
    
    showToast(message, type) {
        // Remove existing toasts
        document.querySelectorAll('.toast-notification').forEach(t => t.remove());
        
        const toast = document.createElement('div');
        toast.className = 'toast-notification';
        
        const bgColor = type === 'success' 
            ? 'linear-gradient(135deg, #2E7D32, #1B5E20)' 
            : 'linear-gradient(135deg, #C62828, #B71C1C)';
        const icon = type === 'success' ? '&#9989;' : '&#10060;';
        
        toast.innerHTML = `<span>${icon}</span> ${message}`;
        toast.style.cssText = `
            position: fixed;
            top: 24px;
            right: 24px;
            background: ${bgColor};
            color: white;
            padding: 1rem 1.5rem;
            border-radius: 14px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.2);
            animation: toastSlideIn 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            z-index: 10000;
            font-weight: 500;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            max-width: 400px;
        `;
        
        document.body.appendChild(toast);
        
        setTimeout(() => {
            toast.style.animation = 'toastSlideOut 0.4s cubic-bezier(0.4, 0, 0.2, 1) forwards';
            setTimeout(() => toast.remove(), 400);
        }, 3500);
    },
    
    getEmptyStateHTML() {
        return `
            <div class="empty-state" style="grid-column: 1 / -1;">
                <div class="empty-state-icon">&#127823;</div>
                <h3>No Food Items Yet</h3>
                <p>Start tracking your food expiry dates by adding your first item.</p>
                <a href="${this.API.BASE_URL}/pages/add-item.jsp" class="btn btn-primary" style="margin-top: 1rem;">
                    + Add Your First Item
                </a>
            </div>
        `;
    }
};

// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    FoodExpiryTracker.init();
});
