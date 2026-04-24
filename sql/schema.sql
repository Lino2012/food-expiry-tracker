-- ============================================
-- Food Expiry Tracker - Database Schema
-- Version: 1.0.0
-- ============================================

CREATE DATABASE IF NOT EXISTS food_expiry_db;
USE food_expiry_db;

-- ============================================
-- Users Table
-- ============================================
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Food Items Table
-- ============================================
CREATE TABLE IF NOT EXISTS food_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) DEFAULT 'Other',
    expiry_date DATE NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    unit VARCHAR(20) DEFAULT 'pieces',
    notes TEXT,
    status ENUM('ACTIVE', 'CONSUMED', 'DISCARDED') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_expiry_date (expiry_date),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Food Statistics View
-- ============================================
CREATE OR REPLACE VIEW v_food_statistics AS
SELECT 
    u.id AS user_id,
    COUNT(CASE WHEN fi.status = 'ACTIVE' THEN 1 END) AS total_items,
    COUNT(CASE WHEN fi.status = 'ACTIVE' AND fi.expiry_date < CURDATE() THEN 1 END) AS expired_items,
    COUNT(CASE WHEN fi.status = 'ACTIVE' AND fi.expiry_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 3 DAY) THEN 1 END) AS expiring_soon,
    COUNT(CASE WHEN fi.status = 'ACTIVE' AND fi.expiry_date > DATE_ADD(CURDATE(), INTERVAL 3 DAY) THEN 1 END) AS safe_items
FROM users u
LEFT JOIN food_items fi ON u.id = fi.user_id
GROUP BY u.id;

-- ============================================
-- Sample Data (Optional - for testing)
-- ============================================
-- INSERT INTO users (username, email, password, full_name) VALUES
-- ('demo', 'demo@example.com', '$2a$10$...', 'Demo User');
