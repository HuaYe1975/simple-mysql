#!/bin/bash
set -e

chown -R mysql:root /var/lib/mysql
chmod 0660 -R /var/lib/mysql

chown -R mysql:root /var/log/mysql
chmod 0660 -R /var/log/mysql

MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-""}
MYSQL_USER_DATABASE=${MYSQL_USER_DATABASE:-""}
MYSQL_USER=${MYSQL_USER:-""}
MYSQL_USER_PASSWORD=${MYSQL_USER_PASSWORD:-""}

rm -rf /var/lib/mysql/*

# Initial Setup
if [ ! -d "/var/lib/mysql/mysql" ] ; then
    mysql_install_db
    mysqld_safe &
    sleep 10
    mysqladmin -u root password ${MYSQL_ROOT_PASSWORD}
    mysql -e "CREATE DATABASE ${MYSQL_USER_DATABASE};" -p${MYSQL_ROOT_PASSWORD}
    mysql -e "CREATE USER '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';" -p${MYSQL_ROOT_PASSWORD}
    mysql -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';" -p${MYSQL_ROOT_PASSWORD}
    mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_USER_DATABASE}.* TO '${MYSQL_USER}'@'localhost';" -p${MYSQL_ROOT_PASSWORD}
    mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_USER_DATABASE}.* TO '${MYSQL_USER}'@'%';" -p${MYSQL_ROOT_PASSWORD}
    killall mysqld
    sleep 10
fi

#exec /usr/sbin/mysqld
mysqld_safe