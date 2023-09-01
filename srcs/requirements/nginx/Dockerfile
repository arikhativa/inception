FROM debian:buster

RUN apt update 
RUN apt install nginx -y 

RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

# COPY ./conf/nginx.conf /etc/nginx
COPY ./conf/nginx.conf /etc/nginx/conf.d
COPY ./tools/install_ssl_cert.sh /install_ssl_cert.sh

RUN mkdir -p /run/nginx

RUN mkdir -p /etc/nginx/ssl
COPY ./tools/yrabby.key /etc/nginx/ssl/yrabby.key
COPY ./tools/yrabby.crt /etc/nginx/ssl/yrabby.crt

# RUN chmod +x /install_ssl_cert.sh

EXPOSE 443

# ENTRYPOINT [ "/install_ssl_cert.sh" ]

CMD ["nginx", "-g", "daemon off;"]
