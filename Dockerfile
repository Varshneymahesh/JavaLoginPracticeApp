# Stage 1: Build
FROM maven:3.9.2-eclipse-temurin-8 AS build
WORKDIR /app

# Copy pom.xml first for caching
COPY pom.xml /app/
RUN mvn dependency:go-offline

# Copy source code
COPY src /app/src

# Build the WAR
RUN mvn clean package

# Stage 2: run the WAR
FROM tomcat:9.0-jdk8-openjdk
COPY --from=build /app/target/JavaLoginShowcase-1.0.0.war $CATALINA_HOME/webapps/JavaLoginShowcase.war
EXPOSE 8080
