# simple-mysql
Dockerfile for dockerhub
You can create your docker container from run.sh

Before execute it, You'd better change the environment var values:
~~~~
NAME='mysql'

MYSQL_DATA="/Users/huaye/DockerProjects/db/data"
MYSQL_LOG="/Users/huaye/DockerProjects/db/log"

DB_ROOT_PASS="passw0rd"
DB_USER="operator"
DB_USER_PASS="operator"
DB_NAME="testdb"
~~~~
