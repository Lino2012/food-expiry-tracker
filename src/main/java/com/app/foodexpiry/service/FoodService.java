package com.app.foodexpiry.service;

import com.app.foodexpiry.dto.FoodItemDTO;
import com.app.foodexpiry.model.FoodItem;
import com.app.foodexpiry.repository.FoodItemRepository;
import com.app.foodexpiry.util.DateUtil;

import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

public class FoodService {
    private final FoodItemRepository foodItemRepository;
    
    public FoodService() {
        this.foodItemRepository = new FoodItemRepository();
    }
    
    public List<FoodItem> getUserFoodItems(int userId) throws SQLException {
        return foodItemRepository.findAllByUserId(userId);
    }
    
    public List<FoodItem> searchFoodItems(int userId, String keyword) throws SQLException {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getUserFoodItems(userId);
        }
        return foodItemRepository.searchByName(userId, keyword.trim());
    }
    
    public List<FoodItem> filterByStatus(int userId, String status) throws SQLException {
        if (status == null || "ALL".equals(status)) {
            return getUserFoodItems(userId);
        }
        return foodItemRepository.findByExpiryStatus(userId, status);
    }
    
    public boolean addFoodItem(int userId, FoodItemDTO dto) throws SQLException {
        FoodItem item = new FoodItem();
        item.setUserId(userId);
        item.setName(dto.getName());
        item.setCategory(dto.getCategory());
        item.setExpiryDate(DateUtil.parseDate(dto.getExpiryDate()));
        item.setQuantity(dto.getQuantity());
        item.setUnit(dto.getUnit());
        item.setNotes(dto.getNotes());
        
        validateFoodItem(item);
        
        return foodItemRepository.create(item);
    }
    
    public boolean deleteFoodItem(int id) throws SQLException {
        return foodItemRepository.delete(id);
    }
    
    public FoodItem getFoodItem(int id) throws SQLException {
        return foodItemRepository.findById(id);
    }
    
    public FoodItemRepository.DashboardStats getDashboardStats(int userId) throws SQLException {
        return foodItemRepository.getDashboardStats(userId);
    }
    
    private void validateFoodItem(FoodItem item) {
        if (item.getName() == null || item.getName().trim().isEmpty()) {
            throw new IllegalArgumentException("Food name is required");
        }
        if (item.getExpiryDate() == null) {
            throw new IllegalArgumentException("Expiry date is required");
        }
        if (item.getExpiryDate().before(new Date(System.currentTimeMillis()))) {
            throw new IllegalArgumentException("Expiry date cannot be in the past");
        }
        if (item.getQuantity() <= 0) {
            throw new IllegalArgumentException("Quantity must be greater than 0");
        }
    }
}