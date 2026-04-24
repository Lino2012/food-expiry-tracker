package com.app.foodexpiry.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.io.InputStream;

/**
 * Database configuration class providing thread-safe connection management.
 * Reads connection properties from application.properties on the classpath.
 */
public class DatabaseConfig {
    private static final String PROPERTIES_FILE = "/application.properties";
    private static Properties properties;
    
    static {
        try {
            properties = new Properties();
            InputStream input = DatabaseConfig.class.getResourceAsStream(PROPERTIES_FILE);
            if (input == null) {
                throw new RuntimeException("application.properties not found on classpath");
            }
            properties.load(input);
            input.close();
            
            String driver = properties.getProperty("db.driver");
            Class.forName(driver);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to load database configuration", e);
        }
    }
    
    /**
     * Returns a new database connection each time (thread-safe).
     * Callers are responsible for closing the connection.
     */
    public static Connection getConnection() throws SQLException {
        // Check for environment variable overrides (for Docker)
        String host = System.getenv("DB_HOST");
        String port = System.getenv("DB_PORT");
        String dbName = System.getenv("DB_NAME");
        String user = System.getenv("DB_USER");
        String password = System.getenv("DB_PASSWORD");
        
        String url;
        String username;
        String pwd;
        
        if (host != null && !host.isEmpty()) {
            // Docker/container mode — use environment variables
            if (port == null || port.isEmpty()) port = "3306";
            if (dbName == null || dbName.isEmpty()) dbName = "food_expiry_db";
            url = "jdbc:mysql://" + host + ":" + port + "/" + dbName 
                  + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
            username = user != null ? user : "root";
            pwd = password != null ? password : "";
        } else {
            // Local mode — use properties file
            url = properties.getProperty("db.url");
            username = properties.getProperty("db.username");
            pwd = properties.getProperty("db.password");
        }
        
        Connection connection = DriverManager.getConnection(url, username, pwd);
        connection.setAutoCommit(true);
        return connection;
    }
}