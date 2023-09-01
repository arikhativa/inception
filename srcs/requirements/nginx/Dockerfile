FROM debian:buster

# Install nginx
RUN apt update 
RUN apt install nginx -y openssl

# Set Logs
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

# Copy nginx config
COPY ./conf/nginx.conf /etc/nginx

# SSL
RUN mkdir -p /etc/nginx/ssl

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
       -out /etc/nginx/ssl/yrabby.crt \
       -keyout /etc/nginx/ssl/yrabby.key \
       -subj "/C=IL/ST=NORTH/L=haifa/O=42/OU=42madrid/CN=yrabby" 2>/dev/null

RUN chmod 600 /etc/nginx/ssl/yrabby.key /etc/nginx/ssl/yrabby.crt

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
