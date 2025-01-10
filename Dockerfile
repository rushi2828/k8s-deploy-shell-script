FROM eclipse-temurin:21-jdk-jammy
 
WORKDIR /

COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ./mvnw dependency:resolve

# COPY src ./src

CMD ["./mvnw", "spring-boot:run"]
