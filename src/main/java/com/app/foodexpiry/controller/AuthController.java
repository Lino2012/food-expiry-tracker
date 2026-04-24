package com.app.foodexpiry.controller;

import com.app.foodexpiry.dto.LoginRequest;
import com.app.foodexpiry.dto.RegisterRequest;
import com.app.foodexpiry.model.User;
import com.app.foodexpiry.service.AuthService;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/auth/*")
public class AuthController extends HttpServlet {
    private AuthService authService;
    private Gson gson;
    
    @Override
    public void init() {
        authService = new AuthService();
        gson = new Gson();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if ("/logout".equals(pathInfo)) {
            handleLogout(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if ("/login".equals(pathInfo)) {
            handleLogin(request, response);
        } else if ("/register".equals(pathInfo)) {
            handleRegister(request, response);
        }
    }
    
    private void handleLogin(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        try {
            LoginRequest loginRequest = gson.fromJson(request.getReader(), LoginRequest.class);
            User user = authService.authenticate(loginRequest);
            
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getId());
                
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true, \"redirect\": \"" + 
                    request.getContextPath() + "/dashboard\"}");
            } else {
                response.setStatus(401);
                response.getWriter().write("{\"success\": false, \"message\": \"Invalid credentials\"}");
            }
        } catch (Exception e) {
            response.setStatus(500);
            response.getWriter().write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }
    
    private void handleRegister(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            RegisterRequest registerRequest = gson.fromJson(request.getReader(), RegisterRequest.class);
            boolean success = authService.register(registerRequest);
            
            if (success) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true, \"message\": \"Registration successful\"}");
            } else {
                response.setStatus(400);
                response.getWriter().write("{\"success\": false, \"message\": \"Registration failed\"}");
            }
        } catch (Exception e) {
            response.setStatus(500);
            response.getWriter().write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }
    
    private void handleLogout(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
    }
}