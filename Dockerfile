# Base image
FROM openjdk:17-jdk-slim

# Create app directory
WORKDIR /app

# Copy app JAR
COPY target/easy-notes-1.0.0.jar app.jar

# Download and extract New Relic agent
RUN apt-get update && apt-get install -y wget unzip && \
    wget https://download.newrelic.com/newrelic/java-agent/newrelic-agent/current/newrelic-java.zip && \
    unzip newrelic-java.zip && \
    rm newrelic-java.zip

# Add your New Relic config
COPY newrelic.yml newrelic/newrelic.yml

# Set environment variables
ENV NEW_RELIC_APP_NAME=SpringBootNotesApp \
    NEW_RELIC_LICENSE_KEY=your_license_key_here \
    JAVA_OPTS="-javaagent:/app/newrelic/newrelic.jar"

# Start the app with the agent
CMD ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
