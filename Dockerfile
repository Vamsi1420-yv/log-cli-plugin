FROM maven:3.9.6-eclipse-temurin-11 AS builder

# Step 1: Preload Jenkins plugin parent POM and hpi packaging
RUN mvn -B org.apache.maven.plugins:maven-dependency-plugin:3.6.0:get \
        -Dartifact=org.jenkins-ci.plugins:plugin:4.64:pom && \
    mvn -B org.apache.maven.plugins:maven-dependency-plugin:3.6.0:get \
        -Dartifact=org.jenkins-ci.tools:maven-hpi-plugin:3.40:pom && \
    mvn -B org.apache.maven.plugins:maven-plugin-plugin:3.6.0:help || true

# Step 2: Create workspace and copy plugin code
WORKDIR /app
COPY . .

# Step 3: Build Jenkins plugin
RUN mvn -B clean install -DskipTests
