FROM openjdk:21-jdk-slim AS builder
EXPOSE 8083
ADD labs/target/labs-0.0.1-SNAPSHOT.war labs-0.0.1-SNAPSHOT.war
ENTRYPOINT ["java","-jar","labs-0.0.1-SNAPSHOT.war"]
