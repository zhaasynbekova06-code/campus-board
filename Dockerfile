FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
# Maven сам найдет pom.xml в любой вложенной папке
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
# Копируем любой собранный jar-файл, где бы он ни собрался
COPY --from=build /app/**/target/*.jar app.jar
EXPOSE 10000
ENTRYPOINT ["java", "-jar", "app.jar"]
