FROM eclipse-temurin:21-jre

# Add metadata labels
LABEL maintainer="kvinltf"
LABEL description="Spring Boot application with gRPC integration"
LABEL version="0.0.1-SNAPSHOT"


WORKDIR /app




# Copy the JAR file
COPY target/spring-grpc-0.0.1-SNAPSHOT.jar app.jar






# Expose ports
EXPOSE 9065
EXPOSE 9064





# Run the application
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]