package com.app.foodexpiry.util;

import com.app.foodexpiry.model.FoodItem;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class DateUtil {
    private static final SimpleDateFormat SQL_DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
    
    public static Date parseDate(String dateStr) {
        if (dateStr == null || dateStr.trim().isEmpty()) {
            throw new IllegalArgumentException("Date string cannot be null or empty");
        }
        
        try {
            java.util.Date parsed = SQL_DATE_FORMAT.parse(dateStr);
            return new Date(parsed.getTime());
        } catch (ParseException e) {
            throw new IllegalArgumentException("Invalid date format. Use yyyy-MM-dd");
        }
    }
    
    public static String formatDate(Date date) {
        if (date == null) return "";
        return SQL_DATE_FORMAT.format(date);
    }
    
    public static void calculateExpiryStatus(FoodItem item) {
        if (item == null || item.getExpiryDate() == null) return;
        
        LocalDate today = LocalDate.now();
        LocalDate expiryDate = item.getExpiryDate().toLocalDate();
        
        long daysUntil = ChronoUnit.DAYS.between(today, expiryDate);
        item.setDaysUntilExpiry(daysUntil);
        
        if (daysUntil < 0) {
            item.setExpiryStatus("EXPIRED");
        } else if (daysUntil <= 3) {
            item.setExpiryStatus("EXPIRING");
        } else {
            item.setExpiryStatus("SAFE");
        }
    }
    
    public static String getStatusBadgeClass(String status) {
        if (status == null) return "badge-default";
        
        switch (status) {
            case "EXPIRED":
                return "badge-expired";
            case "EXPIRING":
                return "badge-expiring";
            case "SAFE":
                return "badge-safe";
            default:
                return "badge-default";
        }
    }
    
    public static String getStatusText(String status) {
        if (status == null) return "Unknown";
        
        switch (status) {
            case "EXPIRED":
                return "Expired";
            case "EXPIRING":
                return "Expiring Soon";
            case "SAFE":
                return "Fresh";
            default:
                return status;
        }
    }
    
    public static String getDaysRemainingText(long days) {
        if (days < 0) {
            long absDays = Math.abs(days);
            return String.format("Expired %d day%s ago", absDays, absDays != 1 ? "s" : "");
        } else if (days == 0) {
            return "Expires today";
        } else {
            return String.format("%d day%s remaining", days, days != 1 ? "s" : "");
        }
    }
}