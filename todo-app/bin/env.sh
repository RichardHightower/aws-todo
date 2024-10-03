#!/bin/bash

# Database configuration
export DB_HOST="localhost"
export DB_PORT="5432"
export DB_NAME="todo_db"
export DB_USER="dbuser"
export DB_PASSWORD="test"
export DB_CONTAINER_NAME="todo-db"

# Additional PostgreSQL configurations
export POSTGRES_MAX_CONNECTIONS="100"
export POSTGRES_SHARED_BUFFERS="256MB"

echo "Database environment variables set."
echo "Original password: $DB_PASSWORD_ORIGINAL"
echo "URL-encoded password: $DB_PASSWORD"
