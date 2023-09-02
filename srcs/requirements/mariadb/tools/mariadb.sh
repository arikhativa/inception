#!/bin/sh

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then 
	echo "Database already exists"
else

SQL_COMMANDS=$(cat <<EOF
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF
)

mysql -h "$MYSQL_HOSTNAME" -u "$MYSQL_USER" -p "$MYSQL_PASSWORD" -e "$SQL_COMMANDS"

if [ $? -eq 0 ]; then
	echo "Database '$MYSQL_DATABASE' created, and privileges granted."
else
	echo "Error: Unable to create the database or grant privileges."
fi

fi

exec "$@"
