# Build stage
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn -q -e -DskipTests dependency:go-offline
COPY src ./src
RUN mvn -q -DskipTests package spring-boot:repackage

# Run stage
FROM eclipse-temurin:17-jre
WORKDIR /app
# Download the OpenTelemetry Java agent
ADD https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar /app/opentelemetry-javaagent.jar
COPY --from=build /app/target/otel-java-demo-0.0.1.jar /app/app.jar

# Copy .env file (optional, for reference)
COPY .env .env

EXPOSE 9000


# Use --env-file .env at runtime to provide OTEL config
ENTRYPOINT ["java","-javaagent:/app/opentelemetry-javaagent.jar","-jar","/app/app.jar"]