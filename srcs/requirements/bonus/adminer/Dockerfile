
FROM debian:buster

# Install
RUN apt -y update
RUN apt install -y php7.3-fpm php-mysql wget 

# Setup php-fpm
RUN mkdir /run/php
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

# Install adminer
RUN mkdir -p /var/www/adminer
RUN wget "http://www.adminer.org/latest.php" -O /var/www/adminer/adminer.php
RUN chown -R www-data:www-data /var/www/adminer/adminer.php 
RUN chmod 755 /var/www/adminer/adminer.php

# Remove redandent files
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www/adminer/

EXPOSE 8080

CMD ["php-fpm7.3", "--nodaemonize"]
