FROM maven:3.8.6-jdk-8

WORKDIR /usr/src/app

COPY pom.xml /usr/src/app
COPY ./src/test/java /usr/src/app/src/test/java
