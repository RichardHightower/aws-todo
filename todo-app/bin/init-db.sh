#!/bin/bash

# Source the environment variables
source "$(dirname "$0")/env.sh"

# Define the path to the SQL init file
SQL_INIT_FILE="$(dirname "$0")/../data/init/init.sql"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker and try again."
    exit 1
fi

# Check if the container is running
if ! docker ps --format '{{.Names}}' | grep -q "^${DB_CONTAINER_NAME}$"; then
    echo "Database container ${DB_CONTAINER_NAME} is not running. Please start it using run-db.sh first."
    exit 1
fi

# Check if the SQL init file exists
if [ ! -f "${SQL_INIT_FILE}" ]; then
    echo "Error: SQL init file not found at ${SQL_INIT_FILE}"
    exit 1
fi

# Run the SQL script inside the Docker container
echo "Initializing database..."
docker exec -i ${DB_CONTAINER_NAME} psql -U ${DB_USER} -d ${DB_NAME} < "${SQL_INIT_FILE}"

# Check if the SQL execution was successful
if [ $? -eq 0 ]; then
    echo "Database initialization completed successfully."
else
    echo "Error: Database initialization failed."
    exit 1
fi

echo "Database ${DB_NAME} has been initialized with the required schema."
