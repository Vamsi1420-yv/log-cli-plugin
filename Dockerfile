FROM maven:3.9.6-eclipse-temurin-11 AS builder

# Install tools if needed (optional)
RUN apt-get update && apt-get install -y git curl unzip && rm -rf /var/lib/apt/lists/*

# Pre-fetch required POMs so Maven understands 'hpi' packaging and BOM
RUN mvn org.apache.maven.plugins:maven-dependency-plugin:3.6.0:get \
      -Dartifact=org.jenkins-ci.plugins:plugin:4.64:pom && \
    mvn org.apache.maven.plugins:maven-dependency-plugin:3.6.0:get \
      -Dartifact=io.jenkins.tools.bom:bom-2.440.x:4034.vd278c5a_2d8a_0:pom || true

# Create app workspace
WORKDIR /app
COPY . .

# Run Maven build
RUN mvn -B clean install -DskipTests

# Optional: For debugging only
# RUN find /root/.m2 -name '*.hpi'
