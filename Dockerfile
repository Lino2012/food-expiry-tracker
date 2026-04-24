FROM tomcat:9.0-jdk11-openjdk-slim

LABEL maintainer="Food Expiry Tracker Team"
LABEL description="Premium Food Expiry Management System"

# Remove default web applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Disable session persistence for cleaner restarts
RUN mkdir -p /usr/local/tomcat/conf && \
    echo '<?xml version="1.0" encoding="UTF-8"?><Context><Manager pathname="" /></Context>' \
    > /usr/local/tomcat/conf/context.xml

# Copy WAR file
COPY target/food-expiry-tracker.war /usr/local/tomcat/webapps/ROOT.war

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1

EXPOSE 8080

CMD ["catalina.sh", "run"]