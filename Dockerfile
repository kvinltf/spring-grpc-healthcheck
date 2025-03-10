FROM eclipse-temurin:21-jre

# Add metadata labels
LABEL maintainer="kvinltf"
LABEL description="Spring Boot application with gRPC integration"
LABEL version="0.0.1-SNAPSHOT"

# Install curl for health checks
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Create a non-root user to run the application
RUN addgroup --system --gid 1001 appgroup && \
    adduser --system --uid 1001 --gid 1001 appuser

WORKDIR /app

# Copy the JAR file
COPY target/spring-grpc-0.0.1-SNAPSHOT.jar app.jar

# Set permissions
RUN chown -R appuser:appgroup /app

# Switch to non-root user
USER appuser

# Expose ports
EXPOSE 9065
EXPOSE 9064

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:9065/actuator/health || exit 1

# Set JVM options
ENV JAVA_OPTS=""

# Run the application
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
