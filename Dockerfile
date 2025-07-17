FROM maven:3.9.6-eclipse-temurin-11

WORKDIR /app

# ⬇️ Add this line to use the Jenkins plugin repositories
COPY .mvn.settings.xml /usr/share/maven/ref/settings.xml

COPY . /app

RUN mvn -B clean install -DskipTests
