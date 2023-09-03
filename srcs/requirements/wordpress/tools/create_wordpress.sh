#!/bin/sh

wp --allow-root core is-installed > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo "wordpress already installed"
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

wp core download --allow-root --version=6.3 --locale=en_US
wp config create --allow-root --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=${MYSQL_HOSTNAME}
wp core install --allow-root --url=${DOMAIN_NAME} --title=${WP_TITLE} --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL}
wp user create --allow-root "${WP_USER}" "${WP_EMAIL}" --user_pass="${WP_PASSWORD}" --role=author

fi

exec "$@"


#check if wp-config.php exist
# if [ -f ./wp-config.php ]
# then
# 	echo "wordpress already downloaded"
# else

####### MANDATORY PART ##########

	#Download wordpress and all config file
	# wget http://wordpress.org/latest.tar.gz
	# tar xfz latest.tar.gz
	# mv wordpress/* .
	# rm -rf latest.tar.gz
	# rm -rf wordpress

	# #Inport env variables in the config file
	# sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
	# sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
	# sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
	# sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
	# cp wp-config-sample.php wp-config.php
###################################

####### BONUS PART ################

## redis ##

	# wp config set WP_REDIS_HOST redis --allow-root #I put --allowroot because i am on the root user on my VM
  	# wp config set WP_REDIS_PORT 6379 --raw --allow-root
 	# wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
  	# #wp config set WP_REDIS_PASSWORD $REDIS_PASSWORD --allow-root
 	# wp config set WP_REDIS_CLIENT phpredis --allow-root
	# wp plugin install redis-cache --activate --allow-root
    # wp plugin update --all --allow-root
	# wp redis enable --allow-root

###  end of redis part  ###

###################################
# fi
