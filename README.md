# Spring gRPC Application

This is a Spring Boot application with gRPC integration.

## Building and Running with Docker

### Prerequisites
- Docker installed on your system
- Maven installed on your system (for building the JAR)

### Build the JAR file
First, build the application JAR file using Maven:

```bash
mvn clean package
```

### Build the Docker image
Build the Docker image using the provided Dockerfile:

```bash
docker build -t spring-grpc .
```

### Run the Docker container
Run the Docker container, exposing both the HTTP and gRPC ports:

```bash
docker run -p 9065:9065 -p 9064:9064 spring-grpc
```

## Ports
- **9065**: HTTP port (Spring Boot web server)
- **9064**: gRPC port

## Health Endpoints
Health endpoints are available at:
- http://localhost:9065/actuator/health
- http://localhost:9065/actuator/info

## Environment Variables
You can customize the application by passing environment variables to the Docker container:

```bash
docker run -p 9065:9065 -p 9064:9064 -e SPRING_PROFILES_ACTIVE=prod spring-grpc
```

### JVM Options
You can customize the JVM options by setting the JAVA_OPTS environment variable:

```bash
docker run -p 9065:9065 -p 9064:9064 -e JAVA_OPTS="-Xmx512m -Xms256m" spring-grpc
```

## Docker Image Features

### Security
The Docker image runs the application as a non-root user (appuser) for improved security.

### Health Check
The Docker image includes a health check that periodically checks the application's health endpoint:
- Interval: 30 seconds
- Timeout: 3 seconds
- Start period: 60 seconds
- Retries: 3

You can view the health status of your container using:
```bash
docker ps
```

### Metadata
The Docker image includes metadata labels:
- maintainer: kvinltf
- description: Spring Boot application with gRPC integration
- version: 0.0.1-SNAPSHOT

## Additional Configuration
For additional configuration options, refer to the Spring Boot documentation.
