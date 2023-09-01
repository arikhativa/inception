
FROM debian:buster

# Install
RUN apt-get update && \
    apt-get install -y php7.3-fpm \
	php-mysql

# Remove redandent files
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /run/php
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

WORKDIR /var/www/html/

CMD ["php-fpm7.3", "--nodaemonize"]

# RUN apt-get update && apt-get -y install \
# 	wget \
# 	curl \
# 	bash \
# 	php \
# 	php-cgi \
# 	php-mysql \
# 	php-fpm \
# 	php-pdo \
# 	php-gd php-cli \
# 	php-mbstring \
# 	redis \
# 	php-redis \
# 	&& rm -rf /var/lib/apt/lists/*


# COPY ./tools/create_wordpress.sh /usr/local/bin/
# RUN chmod +x /usr/local/bin/create_wordpress.sh
# ENTRYPOINT ["/usr/local/bin/create_wordpress.sh"]


# EXPOSE 9000

# CMD ["/usr/sbin/php-fpm7.3", "-F"]

