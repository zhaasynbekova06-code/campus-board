FROM eclipse-temurin:17-jdk-alpine AS build
WORKDIR /app
COPY . .
WORKDIR /app/backend
RUN chmod +x mvnw && ./mvnw clean package -DskipTests

FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY --from=build /app/backend/target/*.jar app.jar
EXPOSE 10000
ENTRYPOINT ["java", "-jar", "app.jar"]
