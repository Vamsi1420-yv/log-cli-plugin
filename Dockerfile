FROM maven:3.9.6-eclipse-temurin-11

WORKDIR /app

# ✅ Add Jenkins plugin repositories to Maven settings
COPY .mvn.settings.xml /usr/share/maven/ref/settings.xml

# Copy source code
COPY . /app

# Build without tests
RUN mvn -B clean install -DskipTests
