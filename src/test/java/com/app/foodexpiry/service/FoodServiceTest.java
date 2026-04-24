package com.app.foodexpiry.service;

import com.app.foodexpiry.dto.FoodItemDTO;
import com.app.foodexpiry.model.FoodItem;
import com.app.foodexpiry.util.DateUtil;
import org.junit.Before;
import org.junit.Test;

import java.sql.Date;
import java.time.LocalDate;

import static org.junit.Assert.*;

public class FoodServiceTest {
    
    @Before
    public void setUp() {
        // Tests validate DateUtil, model classes, and DTOs
        // No database dependency required
    }
    
    @Test
    public void testExpiryCalculation_Expired() {
        FoodItem item = new FoodItem();
        item.setExpiryDate(Date.valueOf(LocalDate.now().minusDays(1)));
        DateUtil.calculateExpiryStatus(item);
        
        assertEquals("EXPIRED", item.getExpiryStatus());
        assertEquals(-1, item.getDaysUntilExpiry());
    }
    
    @Test
    public void testExpiryCalculation_ExpiringSoon() {
        FoodItem item = new FoodItem();
        item.setExpiryDate(Date.valueOf(LocalDate.now().plusDays(2)));
        DateUtil.calculateExpiryStatus(item);
        
        assertEquals("EXPIRING", item.getExpiryStatus());
        assertEquals(2, item.getDaysUntilExpiry());
    }
    
    @Test
    public void testExpiryCalculation_Safe() {
        FoodItem item = new FoodItem();
        item.setExpiryDate(Date.valueOf(LocalDate.now().plusDays(10)));
        DateUtil.calculateExpiryStatus(item);
        
        assertEquals("SAFE", item.getExpiryStatus());
        assertEquals(10, item.getDaysUntilExpiry());
    }
    
    @Test
    public void testExpiryCalculation_ExactDay() {
        FoodItem item = new FoodItem();
        item.setExpiryDate(Date.valueOf(LocalDate.now()));
        DateUtil.calculateExpiryStatus(item);
        
        assertEquals("EXPIRING", item.getExpiryStatus());
        assertEquals(0, item.getDaysUntilExpiry());
    }
    
    @Test
    public void testParseDate_ValidDate() {
        Date pastDate = DateUtil.parseDate("2020-01-01");
        assertNotNull(pastDate);
        assertEquals("2020-01-01", DateUtil.formatDate(pastDate));
        
        Date futureDate = DateUtil.parseDate("2025-12-31");
        assertNotNull(futureDate);
        assertEquals("2025-12-31", DateUtil.formatDate(futureDate));
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void testParseDate_InvalidFormat_WrongSeparator() {
        DateUtil.parseDate("31/12/2024");
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void testParseDate_InvalidFormat_Text() {
        DateUtil.parseDate("invalid-date");
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void testParseDate_InvalidFormat_Empty() {
        DateUtil.parseDate("");
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void testParseDate_NullValue() {
        DateUtil.parseDate(null);
    }
    
    @Test
    public void testFormatDate() {
        Date date = Date.valueOf("2024-12-25");
        String formatted = DateUtil.formatDate(date);
        assertEquals("2024-12-25", formatted);
    }
    
    @Test
    public void testFormatDate_Null() {
        String formatted = DateUtil.formatDate(null);
        assertEquals("", formatted);
    }
    
    @Test
    public void testGetStatusBadgeClass() {
        assertEquals("badge-expired", DateUtil.getStatusBadgeClass("EXPIRED"));
        assertEquals("badge-expiring", DateUtil.getStatusBadgeClass("EXPIRING"));
        assertEquals("badge-safe", DateUtil.getStatusBadgeClass("SAFE"));
        assertEquals("badge-default", DateUtil.getStatusBadgeClass("UNKNOWN"));
        assertEquals("badge-default", DateUtil.getStatusBadgeClass(null));
    }
    
    @Test
    public void testGetStatusText() {
        assertEquals("Expired", DateUtil.getStatusText("EXPIRED"));
        assertEquals("Expiring Soon", DateUtil.getStatusText("EXPIRING"));
        assertEquals("Fresh", DateUtil.getStatusText("SAFE"));
        assertEquals("CUSTOM", DateUtil.getStatusText("CUSTOM"));
        assertEquals("Unknown", DateUtil.getStatusText(null));
    }
    
    @Test
    public void testGetDaysRemainingText() {
        assertEquals("Expired 1 day ago", DateUtil.getDaysRemainingText(-1));
        assertEquals("Expired 5 days ago", DateUtil.getDaysRemainingText(-5));
        assertEquals("Expires today", DateUtil.getDaysRemainingText(0));
        assertEquals("1 day remaining", DateUtil.getDaysRemainingText(1));
        assertEquals("7 days remaining", DateUtil.getDaysRemainingText(7));
    }
    
    @Test
    public void testFoodItemDTOValidation() {
        FoodItemDTO dto = new FoodItemDTO();
        dto.setName("Apple");
        dto.setCategory("Fruits");
        dto.setExpiryDate("2024-12-31");
        dto.setQuantity(5);
        dto.setUnit("pieces");
        dto.setNotes("Fresh apples");
        
        assertEquals("Apple", dto.getName());
        assertEquals("Fruits", dto.getCategory());
        assertEquals("2024-12-31", dto.getExpiryDate());
        assertEquals(5, dto.getQuantity());
        assertEquals("pieces", dto.getUnit());
        assertEquals("Fresh apples", dto.getNotes());
    }
    
    @Test
    public void testFoodItemModel() {
        FoodItem item = new FoodItem();
        item.setId(1);
        item.setUserId(100);
        item.setName("Milk");
        item.setExpiryDate(Date.valueOf("2024-12-31"));
        
        assertEquals(1, item.getId());
        assertEquals(100, item.getUserId());
        assertEquals("Milk", item.getName());
        assertEquals(Date.valueOf("2024-12-31"), item.getExpiryDate());
    }
    
    @Test
    public void testValidationUtil_Email() {
        assertTrue(com.app.foodexpiry.util.ValidationUtil.isValidEmail("test@example.com"));
        assertFalse(com.app.foodexpiry.util.ValidationUtil.isValidEmail(null));
        assertFalse(com.app.foodexpiry.util.ValidationUtil.isValidEmail("invalid"));
    }
    
    @Test
    public void testCalculateExpiryStatus_NullItem() {
        // Should not throw exception
        DateUtil.calculateExpiryStatus(null);
    }
    
    @Test
    public void testCalculateExpiryStatus_NullDate() {
        FoodItem item = new FoodItem();
        item.setExpiryDate(null);
        
        // Should not throw exception
        DateUtil.calculateExpiryStatus(item);
        assertNull(item.getExpiryStatus());
        assertEquals(0, item.getDaysUntilExpiry());
    }
}