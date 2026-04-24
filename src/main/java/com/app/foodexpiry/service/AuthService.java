package com.app.foodexpiry.service;

import com.app.foodexpiry.dto.LoginRequest;
import com.app.foodexpiry.dto.RegisterRequest;
import com.app.foodexpiry.model.User;
import com.app.foodexpiry.repository.UserRepository;

import java.sql.SQLException;

public class AuthService {
    private final UserRepository userRepository;
    
    public AuthService() {
        this.userRepository = new UserRepository();
    }
    
    public User authenticate(LoginRequest request) throws SQLException {
        User user = userRepository.findByUsername(request.getUsername());
        
        if (user != null && userRepository.validatePassword(request.getPassword(), user.getPassword())) {
            // Don't send password to client
            user.setPassword(null);
            return user;
        }
        
        return null;
    }
    
    public boolean register(RegisterRequest request) throws SQLException {
        // Check if username or email already exists
        User existingUser = userRepository.findByUsername(request.getUsername());
        if (existingUser != null) {
            throw new RuntimeException("Username already exists");
        }
        
        User newUser = new User();
        newUser.setUsername(request.getUsername());
        newUser.setEmail(request.getEmail());
        newUser.setPassword(request.getPassword());
        newUser.setFullName(request.getFullName());
        
        return userRepository.create(newUser);
    }
    
    public User getUserById(int id) throws SQLException {
        User user = userRepository.findById(id);
        if (user != null) {
            user.setPassword(null);
        }
        return user;
    }
}