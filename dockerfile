FROM openjdk:11-jdk-alpine
ARG JAR_FILE=build/libs/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","${JAVA_OPTS}","-jar","/app.jar"]