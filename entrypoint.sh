#!/bin/sh
set -e

echo "Removing old migrations and database..."
rm -rf migrations
rm -f instance/app.db

echo "Initializing database migrations..."
flask db init
echo "Creating initial migration..."
flask db migrate -m "initial migration"
echo "Attempting to run database migrations..."
flask db upgrade
echo "Database migrations complete."

echo "Starting Gunicorn..."
gunicorn -w 4 -b 0.0.0.0:1199 app:app