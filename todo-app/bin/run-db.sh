#!/bin/bash

set -x

# Source the environment variables
source "$(dirname "$0")/env.sh"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker and try again."
    exit 1
fi

# Check if the container already exists
if docker ps -a --format '{{.Names}}' | grep -q "^${DB_CONTAINER_NAME}$"; then
    # Check if the container is running
    if docker ps --format '{{.Names}}' | grep -q "^${DB_CONTAINER_NAME}$"; then
        echo "Database container ${DB_CONTAINER_NAME} is already running."
    else
        echo "Starting existing database container ${DB_CONTAINER_NAME}..."
        docker start ${DB_CONTAINER_NAME}
    fi
else
    echo "Creating and starting new database container ${DB_CONTAINER_NAME}..."
    docker run --name ${DB_CONTAINER_NAME} \
        -e POSTGRES_USER=${DB_USER} \
        -e POSTGRES_PASSWORD=${DB_PASSWORD} \
        -e POSTGRES_DB=${DB_NAME} \
        -p ${DB_PORT}:5432 \
        -d postgres:14.5
fi

echo "Waiting for database to be ready..."
until docker exec ${DB_CONTAINER_NAME} pg_isready > /dev/null 2>&1; do
    echo -n "."
    sleep 1
done
echo " Database is ready!"

echo "Database container ${DB_CONTAINER_NAME} is now running."
echo "You can connect to it using:"
echo "  Host: ${DB_HOST}"
echo "  Port: ${DB_PORT}"
echo "  Database: ${DB_NAME}"
echo "  User: ${DB_USER}"
echo "  Password: <the password you set in env.sh>"

# Optionally, you can run psql here if you want to connect immediately
# docker exec -it ${DB_CONTAINER_NAME} psql -U ${DB_USER} -d ${DB_NAME}
