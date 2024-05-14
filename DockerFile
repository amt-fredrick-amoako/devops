FROM openjdk:8
EXPOSE 8082
ADD labs/target/labs-0.0.1-SNAPSHOT.war labs-0.0.1-SNAPSHOT.war
ENTRYPOINT ["java","-jar","target/labs-0.0.1-SNAPSHOT.war"]