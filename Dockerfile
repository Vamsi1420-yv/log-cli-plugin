FROM maven:3.9.6-eclipse-temurin-11

WORKDIR /app

# Optional: Use Jenkins Maven mirror if network issues exist
COPY .mvn.settings.xml /usr/share/maven/ref/settings.xml

# Pre-install maven-hpi-plugin to recognize <packaging>hpi</packaging>
RUN mvn -B org.jenkins-ci.tools:maven-hpi-plugin:3.4:hpi || true

# Now copy source after plugin is cached
COPY . .

# Now build without tests
RUN mvn -B clean install -DskipTests
