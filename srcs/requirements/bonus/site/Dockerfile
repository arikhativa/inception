FROM debian:buster

RUN apt update
RUN apt install -y nginx 

COPY ./tools /var/www/html
COPY ./conf/nginx.conf /etc/nginx/conf.d

WORKDIR /var/www/html

EXPOSE 8081

CMD ["nginx", "-g", "daemon off;"]
