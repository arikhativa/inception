#!/bin/sh

# mysql -h "$MYSQL_HOSTNAME" -u "$MYSQL_USER" -p$MYSQL_PASSWORD -e "show tables from $MYSQL_DATABASE;"
# if [ $? -eq 0 ]; then
# 	echo "Database already exists"
# else


if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then 
	echo "Database already exists"
else

sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf
# sed -i 's/#bind-address/bind-address/g' /etc/my.cnf.d/mariadb-server.cnf

echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" > /tmp/init.sql
echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> /tmp/init.sql
echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';" >> /tmp/init.sql
echo "FLUSH PRIVILEGES;" >> /tmp/init.sql

fi

exec "$@"
