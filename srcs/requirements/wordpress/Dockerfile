
FROM debian:buster

# Install
RUN apt update 
RUN apt install -y php7.3-fpm \
	mariadb-client \
	php-mysql \
	curl

# Install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Remove redandent files
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Setup php-fpm
RUN mkdir /run/php
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

# Setup wordpress installation
COPY ./tools/create_wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/create_wordpress.sh

WORKDIR /var/www/html/

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/create_wordpress.sh"]

CMD ["php-fpm7.3", "--nodaemonize"]
