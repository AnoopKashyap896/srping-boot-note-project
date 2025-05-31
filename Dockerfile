FROM openjdk:17-jdk-alpine

# Set New Relic version and download URL
ENV NEW_RELIC_VERSION=7.6.0
ENV NEW_RELIC_HOME=C:/Users/anoop/newrelic-java/newrelic

# Download and extract New Relic agent
RUN apk add --no-cache curl \
    && curl -L https://download.newrelic.com/newrelic/java-agent/newrelic-agent/${NEW_RELIC_VERSION}/newrelic-java.zip -o /tmp/newrelic-java.zip \
    && unzip /tmp/newrelic-java.zip -d / \
    && rm /tmp/newrelic-java.zip

# Copy your app jar
COPY target/*.jar app.jar

# Copy your New Relic config (you'll need to create this with your license key)
COPY newrelic.yml ${NEW_RELIC_HOME}/newrelic.yml

ENV JAVA_OPTS="-javaagent:${NEW_RELIC_HOME}/newrelic.jar"

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar /app.jar"]
