FROM jenkins/plugin

WORKDIR /app

COPY . /app

RUN mvn clean install -Dchangelist=999999-SNAPSHOT -DskipTests
