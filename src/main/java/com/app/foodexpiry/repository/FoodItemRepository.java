package com.app.foodexpiry.repository;

import com.app.foodexpiry.config.DatabaseConfig;
import com.app.foodexpiry.model.FoodItem;
import com.app.foodexpiry.util.DateUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FoodItemRepository {
    
    public List<FoodItem> findAllByUserId(int userId) throws SQLException {
        String sql = "SELECT * FROM food_items WHERE user_id = ? AND status = 'ACTIVE' ORDER BY expiry_date ASC";
        List<FoodItem> items = new ArrayList<>();
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                FoodItem item = mapResultSetToFoodItem(rs);
                DateUtil.calculateExpiryStatus(item);
                items.add(item);
            }
        }
        
        return items;
    }
    
    public List<FoodItem> searchByName(int userId, String keyword) throws SQLException {
        String sql = "SELECT * FROM food_items WHERE user_id = ? AND name LIKE ? AND status = 'ACTIVE' ORDER BY expiry_date ASC";
        List<FoodItem> items = new ArrayList<>();
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setString(2, "%" + keyword + "%");
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                FoodItem item = mapResultSetToFoodItem(rs);
                DateUtil.calculateExpiryStatus(item);
                items.add(item);
            }
        }
        
        return items;
    }
    
    public List<FoodItem> findByExpiryStatus(int userId, String status) throws SQLException {
        String sql = "SELECT * FROM food_items WHERE user_id = ? AND status = 'ACTIVE'";
        
        if ("EXPIRED".equals(status)) {
            sql += " AND expiry_date < CURDATE()";
        } else if ("EXPIRING".equals(status)) {
            sql += " AND expiry_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 3 DAY)";
        } else if ("SAFE".equals(status)) {
            sql += " AND expiry_date > DATE_ADD(CURDATE(), INTERVAL 3 DAY)";
        }
        
        sql += " ORDER BY expiry_date ASC";
        
        List<FoodItem> items = new ArrayList<>();
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                FoodItem item = mapResultSetToFoodItem(rs);
                DateUtil.calculateExpiryStatus(item);
                items.add(item);
            }
        }
        
        return items;
    }
    
    public FoodItem findById(int id) throws SQLException {
        String sql = "SELECT * FROM food_items WHERE id = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                FoodItem item = mapResultSetToFoodItem(rs);
                DateUtil.calculateExpiryStatus(item);
                return item;
            }
        }
        
        return null;
    }
    
    public boolean create(FoodItem item) throws SQLException {
        String sql = "INSERT INTO food_items (user_id, name, category, expiry_date, quantity, unit, notes) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, item.getUserId());
            stmt.setString(2, item.getName());
            stmt.setString(3, item.getCategory());
            stmt.setDate(4, item.getExpiryDate());
            stmt.setInt(5, item.getQuantity());
            stmt.setString(6, item.getUnit());
            stmt.setString(7, item.getNotes());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    item.setId(rs.getInt(1));
                }
                return true;
            }
        }
        
        return false;
    }
    
    public boolean delete(int id) throws SQLException {
        String sql = "UPDATE food_items SET status = 'CONSUMED' WHERE id = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }
    
    public DashboardStats getDashboardStats(int userId) throws SQLException {
        String sql = "SELECT * FROM v_food_statistics WHERE user_id = ?";
        DashboardStats stats = new DashboardStats();
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                stats.totalItems = rs.getInt("total_items");
                stats.expiredItems = rs.getInt("expired_items");
                stats.expiringSoon = rs.getInt("expiring_soon");
                stats.safeItems = rs.getInt("safe_items");
            }
        }
        
        return stats;
    }
    
    private FoodItem mapResultSetToFoodItem(ResultSet rs) throws SQLException {
        FoodItem item = new FoodItem();
        item.setId(rs.getInt("id"));
        item.setUserId(rs.getInt("user_id"));
        item.setName(rs.getString("name"));
        item.setCategory(rs.getString("category"));
        item.setExpiryDate(rs.getDate("expiry_date"));
        item.setQuantity(rs.getInt("quantity"));
        item.setUnit(rs.getString("unit"));
        item.setNotes(rs.getString("notes"));
        item.setStatus(rs.getString("status"));
        item.setCreatedAt(rs.getTimestamp("created_at"));
        item.setUpdatedAt(rs.getTimestamp("updated_at"));
        return item;
    }
    
    public static class DashboardStats {
        public int totalItems;
        public int expiredItems;
        public int expiringSoon;
        public int safeItems;
    }
}