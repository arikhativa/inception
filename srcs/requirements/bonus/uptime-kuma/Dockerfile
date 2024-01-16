FROM debian:buster

RUN apt update
RUN apt install -y npm git curl wget

RUN npm install -g n
RUN n 20.4

RUN npm install npm@9 -g

RUN git config --global http.version HTTP/1.1
RUN git config --global http.postBuffer 524288000

RUN git clone https://github.com/louislam/uptime-kuma.git /var/www/html

WORKDIR /var/www/html

RUN npm run setup

EXPOSE 3001

CMD ["node", "server/server.js"]
