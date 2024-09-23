FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    curl \
    tar \
    wget \
    openjdk-8-jdk

# Install Maven
RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
    && curl -fsSL -o /tmp/apache-maven.tar.gz https://apache.osuosl.org/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.tar.gz \
    && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
    && rm -f /tmp/apache-maven.tar.gz \
    && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Compile the project
RUN mvn compile

# Run tests
RUN mvn clean test

# Set the default command
CMD ["mvn", "clean", "install"]

WORKDIR /app
# Copy the run_tests.sh script to the root of the container
COPY run_tests.sh /run_tests.sh

# Make the script executable
RUN chmod +x /run_tests.sh
ENTRYPOINT ["/bin/bash", "-s"]