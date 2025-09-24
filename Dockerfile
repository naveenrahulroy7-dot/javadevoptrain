# Use official Maven image to build the app
FROM maven:3.8.7-openjdk-11 AS build

WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Use lightweight JDK runtime image
FROM openjdk:11-jre-slim

WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
