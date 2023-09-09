FROM debian:buster

RUN apt update
RUN apt install -y npm git curl wget

RUN npm install -g n
RUN n 16

RUN npm install npm@9 -g

RUN git clone https://github.com/louislam/uptime-kuma.git /var/www/html

WORKDIR /var/www/html

RUN npm run setup

EXPOSE 3001

CMD ["node", "server/server.js"]
