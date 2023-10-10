#!/bin/sh

wp --allow-root core is-installed > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo "wordpress already installed"
	exec "$@"
	exit 0
else

cd /var/www/html

# Wait for mysql to be up and running
start_time=$(date +%s)
timeout_duration=60

while true; do
	mysql -u $MYSQL_USER -h $MYSQL_HOSTNAME -p"$MYSQL_PASSWORD" -e "show databases" > /dev/null 2>&1

    if [ $? -eq 0 ]; then
		# Found mysql
        break
    else
        current_time=$(date +%s)
        elapsed_time=$((current_time - start_time))

        if [ $elapsed_time -ge $timeout_duration ]; then
			echo "Timeout: Couldn't connect to mysql"
			exit 1
        else
            sleep 1
        fi
    fi
done

# Mandatory
wp core download --allow-root --version=6.3 --locale=en_US
wp config create --allow-root --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=${MYSQL_HOSTNAME}
wp core install --allow-root --url=${DOMAIN_NAME} --title=${WP_TITLE} --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL}
wp user create --allow-root "${WP_USER}" "${WP_EMAIL}" --user_pass="${WP_PASSWORD}" --role=author
wp config set --allow-root WP_DEBUG true
wp config set --allow-root WP_DEBUG_DISPLAY true
wp config set --allow-root WP_DEBUG_LOG true
echo "ini_set('error_log', 'php://stdout');" >> /var/www/html/wp-config.php 

# Bonus
## FTP
wp config set --allow-root FS_METHOD ftpext
wp config set --allow-root FTP_HOST $FTP_HOST
wp config set --allow-root FTP_USER $FTP_USER
wp config set --allow-root FTP_PASS $FTP_PASS
wp config set --allow-root FTP_PORT 21

## Redis
cd /var/www/html/wp-content/plugins

wp config set --allow-root WP_REDIS_HOST redis
wp config set --allow-root WP_REDIS_PORT 6379
wp config set --allow-root WP_CACHE_KEY_SALT $DOMAIN_NAME

wp plugin install redis-cache --allow-root --activate
wp plugin update --all --allow-root
wp redis enable --allow-root

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

fi

exec "$@"
