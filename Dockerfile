# Step 1: Use an official Maven image to build the project
FROM maven:3.9.9-eclipse-temurin-17 AS build

# Set working directory inside container
WORKDIR /app

# Copy project files
COPY pom.xml .
#COPY src ./src

# Build the project and create a jar file
#RUN mvn clean package -DskipTests

# Step 2: Use a lightweight JRE image to run the jar
#  FROM eclipse-temurin:17-jre-alpine

# Set work directory
#WORKDIR /app

# Copy the jar from build stage
#COPY --from=build /app/target/*.jar app.jar

# Expose application port (change if different)
#EXPOSE 8080

# Command to run the application
#ENTRYPOINT ["java", "-jar", "app.jar"]
