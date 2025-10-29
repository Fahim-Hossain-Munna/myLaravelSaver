#!/bin/bash

echo "Starting Laravel project setup..."

# Check if .env file exists
if [ ! -f ".env" ]; then
    echo "Copying .env.example to .env"
    cp .env.example .env
    echo ".env copied."
else
    echo ".env already exists, skipping copy..."
fi

# Prompt for App settings
read -p "Enter your App Name [default: LaravelApp]: " INPUT_APP_NAME
APP_NAME=${INPUT_APP_NAME:-LaravelApp}

read -p "Enter your App URL [default: http://localhost]: " INPUT_APP_URL
APP_URL=${INPUT_APP_URL:-http://localhost}

# Update .env with App settings
sed -i "s|^APP_NAME=.*|APP_NAME=\"$APP_NAME\"|" .env
sed -i "s|^APP_URL=.*|APP_URL=$APP_URL|" .env

# Load existing DB credentials from .env if any
source <(grep -E "DB_HOST=|DB_PORT=|DB_DATABASE=|DB_USERNAME=|DB_PASSWORD=" .env)

# Install PHP dependencies
echo "Installing Composer dependencies..."
composer install

# Install Node dependencies
echo "Installing NPM dependencies..."
npm install

# Generate app key
echo "Generating application key..."
php artisan key:generate

# Check if database exists
echo "Checking if database '$DB_DATABASE' exists..."
DB_EXIST=$(mysql -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USERNAME" -p"$DB_PASSWORD" -e "SHOW DATABASES LIKE '$DB_DATABASE';" 2>/dev/null | grep "$DB_DATABASE")

if [ "$DB_EXIST" == "$DB_DATABASE" ]; then
    echo "Database exists — running migrate:fresh --seed..."
    php artisan migrate:fresh --seed
else
    echo "Database does not exist — let's create it."

    # Prompt user for DB information
    read -p "Enter DB host [default: 127.0.0.1]: " INPUT_DB_HOST
    DB_HOST=${INPUT_DB_HOST:-127.0.0.1}

    read -p "Enter DB port [default: 3306]: " INPUT_DB_PORT
    DB_PORT=${INPUT_DB_PORT:-3306}

    read -p "Enter DB name: " DB_DATABASE
    read -p "Enter DB username [default: root]: " INPUT_DB_USERNAME
    DB_USERNAME=${INPUT_DB_USERNAME:-root}

    read -s -p "Enter DB password: " DB_PASSWORD
    echo ""

    # Update .env with the entered values
    sed -i "s/^DB_CONNECTION=.*/DB_CONNECTION=mysql/" .env
    sed -i "s/^DB_HOST=.*/DB_HOST=$DB_HOST/" .env
    sed -i "s/^DB_PORT=.*/DB_PORT=$DB_PORT/" .env
    sed -i "s/^DB_DATABASE=.*/DB_DATABASE=$DB_DATABASE/" .env
    sed -i "s/^DB_USERNAME=.*/DB_USERNAME=$DB_USERNAME/" .env
    sed -i "s/^DB_PASSWORD=.*/DB_PASSWORD=$DB_PASSWORD/" .env

    # Create the database
    mysql -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USERNAME" -p"$DB_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`$DB_DATABASE\`;"
    echo "Database '$DB_DATABASE' created."

    # Run migrations and seeders
    php artisan migrate --seed
fi

# Create storage link
echo "Creating storage link..."
php artisan storage:link

# Build assets
echo "Building frontend assets..."
npm run build

# Cache configs
echo "Caching configurations..."
php artisan optimize:clear

echo "Setup completed successfully!"

# # Start local server
# echo "Starting server..."
# php artisan serve
