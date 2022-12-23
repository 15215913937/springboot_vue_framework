FROM openjdk:8-jdk-slim
LABEL maintainer = qinanshen

COPY target/*.jar /sqn_app.jar
ENTRYPOINT["java","-jar","/sqn_app.jar"]