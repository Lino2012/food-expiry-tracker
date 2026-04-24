package com.app.foodexpiry.dto;

public class FoodItemDTO {
    private int id;
    private String name;
    private String category;
    private String expiryDate;
    private int quantity;
    private String unit;
    private String notes;
    
    public FoodItemDTO() {}
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    
    public String getExpiryDate() { return expiryDate; }
    public void setExpiryDate(String expiryDate) { this.expiryDate = expiryDate; }
    
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }
    
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
}