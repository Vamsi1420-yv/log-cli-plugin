# Stage 1: Build plugin with Maven and Java 11
FROM maven:3.9.6-eclipse-temurin-11 AS builder

# Set working directory
WORKDIR /app

# Copy source code
COPY . .

# Ensure Git is installed for plugin SCM tagging
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Build the Jenkins plugin without running tests
RUN mvn clean install -DskipTests

# Stage 2: Runtime stage (if needed)
# OR extract the .hpi from the build stage
FROM eclipse-temurin:11-jre

# Copy the built plugin .hpi file
COPY --from=builder /app/target/*.hpi /log-cli.hpi

# Optional: default CMD
CMD ["echo", "Built log-cli.hpi is available at /log-cli.hpi"]
