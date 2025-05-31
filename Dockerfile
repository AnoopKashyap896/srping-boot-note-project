# Use OpenJDK 17 base image
FROM openjdk:17-jdk-alpine

# Add a volume for logs (optional)
VOLUME /tmp

# Copy JAR from build to container
COPY target/*.jar app.jar

# Set environment variables (optional)
ENV JAVA_OPTS=""

# Run the JAR
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar /app.jar"]
