FROM debian:buster

RUN apt update 
RUN apt install nginx -y openssl

RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
       -out /etc/nginx/ssl/yrabby.crt \
       -keyout /etc/nginx/ssl/yrabby.key \
       -subj "/C=IL/ST=NORTH/L=haifa/O=42/OU=42madrid/CN=yrabby"

RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

COPY ./conf/nginx.conf /etc/nginx

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
