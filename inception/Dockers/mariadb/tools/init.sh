#!/bin/bash

echo "starting script"

if [ -d "/var/lib/mysql/$SQL_DATABASE" ]; then 
    echo "Database already exists"
else
    echo "creating database"

    service mysql start

    # Sleep for a short period to allow MySQL to start
    sleep 10


    # Verify MySQL root password
    if ! mysql -u root -p"$SQL_ROOT_PASSWORD" -e "SELECT 1;" > /dev/null 2>&1; then
        echo "ERROR: Incorrect root password."
        exit 1
    fi

    # Retry the MySQL operations after waiting
    echo "Create Database"
    mysql -u root -p"$SQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;" || { echo "ERROR: Unable to create database."; exit 1; }

    echo "Create User"
    mysql -u root -p"$SQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';" || { echo "ERROR: Unable to create user."; exit 1; }

    echo "Grant Privileges"
    mysql -u root -p"$SQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';" || { echo "ERROR: Unable to grant privileges."; exit 1; }

    echo "Flush privileges"
    mysql -u root -p"$SQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;" || { echo "ERROR: Unable to flush privileges."; exit 1; }

    echo "Shutdown MySQL"
    mysqladmin -u root -p"$SQL_ROOT_PASSWORD" shutdown || { echo "ERROR: Unable to shutdown MySQL."; exit 1; }

	# Set root password
	mysqladmin -u root password "$SQL_ROOT_PASSWORD"
fi

echo "Start the MySQL service using mysqld_safe"
mysqld_safe