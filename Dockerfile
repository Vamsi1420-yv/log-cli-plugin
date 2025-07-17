FROM maven:3.9.6-eclipse-temurin-11

WORKDIR /app

# 🔹 Copy Maven settings to get Jenkins repos (if needed)
COPY .mvn.settings.xml /usr/share/maven/ref/settings.xml

# 🔹 Pre-install the maven-hpi-plugin to avoid "Unknown packaging: hpi"
RUN mvn org.apache.maven.plugins:maven-plugin-plugin:3.6.0:descriptor \
 && mvn org.jenkins-ci.tools:maven-hpi-plugin:3.4:help -Ddetail=true -Dgoal=help \
 || true

# 🔹 Copy source code after plugin install
COPY . .

# 🔹 Build the project
RUN mvn -B clean install -DskipTests
