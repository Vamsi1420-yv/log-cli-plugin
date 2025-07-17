FROM maven:3.9.6-eclipse-temurin-11

# Step 1: Preload Jenkins plugin packaging requirements
RUN mvn -B org.apache.maven.plugins:maven-dependency-plugin:3.6.0:get \
        -Dartifact=org.jenkins-ci.plugins:plugin:4.64:pom && \
    mvn -B org.apache.maven.plugins:maven-dependency-plugin:3.6.0:get \
        -Dartifact=org.jenkins-ci.tools:maven-hpi-plugin:3.40 && \
    mvn -B org.apache.maven.plugins:maven-dependency-plugin:3.6.0:get \
        -Dartifact=org.jenkins-ci.tools:maven-hpi-plugin:3.40:pom && \
    echo "✅ Jenkins plugin dependencies preloaded."

# Step 2: Copy plugin code
WORKDIR /app
COPY . .

# Step 3: Build plugin
RUN mvn -B clean install -DskipTests
