package com.app.foodexpiry.controller;

import com.app.foodexpiry.dto.FoodItemDTO;
import com.app.foodexpiry.model.FoodItem;
import com.app.foodexpiry.repository.FoodItemRepository;
import com.app.foodexpiry.service.FoodService;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/food/*")
public class FoodController extends HttpServlet {
    private FoodService foodService;
    private Gson gson;
    
    @Override
    public void init() {
        foodService = new FoodService();
        gson = new Gson();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendError(401);
            return;
        }
        
        String pathInfo = request.getPathInfo();
        int userId = (int) session.getAttribute("userId");
        
        try {
            if ("/list".equals(pathInfo)) {
                List<FoodItem> items = foodService.getUserFoodItems(userId);
                response.setContentType("application/json");
                response.getWriter().write(gson.toJson(items));
            } else if ("/stats".equals(pathInfo)) {
                FoodItemRepository.DashboardStats stats = foodService.getDashboardStats(userId);
                response.setContentType("application/json");
                response.getWriter().write(gson.toJson(stats));
            } else if ("/search".equals(pathInfo)) {
                String keyword = request.getParameter("q");
                String status = request.getParameter("status");
                
                List<FoodItem> items;
                if (status != null && !"ALL".equals(status)) {
                    items = foodService.filterByStatus(userId, status);
                } else if (keyword != null && !keyword.isEmpty()) {
                    items = foodService.searchFoodItems(userId, keyword);
                } else {
                    items = foodService.getUserFoodItems(userId);
                }
                
                response.setContentType("application/json");
                response.getWriter().write(gson.toJson(items));
            }
        } catch (SQLException e) {
            response.setStatus(500);
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendError(401);
            return;
        }
        
        int userId = (int) session.getAttribute("userId");
        
        try {
            FoodItemDTO dto = gson.fromJson(request.getReader(), FoodItemDTO.class);
            boolean success = foodService.addFoodItem(userId, dto);
            
            Map<String, Object> result = new HashMap<>();
            result.put("success", success);
            
            if (success) {
                result.put("message", "Food item added successfully");
                response.setStatus(201);
            } else {
                result.put("message", "Failed to add food item");
                response.setStatus(400);
            }
            
            response.setContentType("application/json");
            response.getWriter().write(gson.toJson(result));
            
        } catch (IllegalArgumentException e) {
            response.setStatus(400);
            response.getWriter().write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        } catch (Exception e) {
            response.setStatus(500);
            response.getWriter().write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }
    
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendError(401);
            return;
        }
        
        try {
            String pathInfo = request.getPathInfo();
            String[] splits = pathInfo.split("/");
            
            if (splits.length > 1) {
                int id = Integer.parseInt(splits[1]);
                boolean success = foodService.deleteFoodItem(id);
                
                Map<String, Object> result = new HashMap<>();
                result.put("success", success);
                result.put("message", success ? "Item deleted successfully" : "Failed to delete item");
                
                response.setContentType("application/json");
                response.getWriter().write(gson.toJson(result));
            }
        } catch (Exception e) {
            response.setStatus(500);
            response.getWriter().write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }
}