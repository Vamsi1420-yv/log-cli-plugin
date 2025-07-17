FROM maven:3.9.6-eclipse-temurin-11

# Add Jenkins plugin repo to Maven settings
COPY .mvn.settings.xml /usr/share/maven/ref/settings.xml

WORKDIR /app
COPY . .

# Build with correct repo access
RUN mvn -B clean install -DskipTests
