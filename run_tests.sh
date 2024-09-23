#!/bin/bash

# Set the working directory to the project root
cd /app

# Run Maven tests without downloading dependencies or connecting to the internet
mvn test -o -Dmaven.repo.local=/root/.m2/repository

# Print the test results
echo "Test execution completed. Please check the output above for results."