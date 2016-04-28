#!/bin/bash -e

# An example script to run MySQL in production

NAME='mysql'

MYSQL_DATA="/Users/huaye/DockerProjects/db/data"
MYSQL_LOG="/Users/huaye/DockerProjects/db/log"

DB_ROOT_PASS="passw0rd"
DB_USER="operator"
DB_USER_PASS="operator"
DB_NAME="testdb"

mkdir -p "$MYSQL_DATA"
mkdir -p "$MYSQL_LOG"

docker stop "${NAME}" || true
sleep 1
docker rm "${NAME}" || true
sleep 1
docker run -d --restart=always --name "${NAME}" \
	 -v "${MYSQL_LOG}:/var/log/mysql" \
	 -v "${MYSQL_DATA}:/var/lib/mysql" \
	 -e MYSQL_ROOT_PASSWORD=${DB_ROOT_PASS} \
	 -e MYSQL_USER=${DB_USER} \
	 -e MYSQL_USER_PASSWORD=${DB_USER_PASS} \
	 -e MYSQL_USER_DATABASE=${DB_NAME} \
	 romeohua/simple-mysql:v5.7