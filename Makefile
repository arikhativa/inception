

# nginx
# NGINX_IMG := nginx
# NGINX_DF := ./nginx/nginx_dep.dockerfile

# DOCKER-COMPOSE
DC_FILE := ./srcs/docker-compose.yml
DC := docker-compose -f $(DC_FILE)

all:
	$(DC) up -d --build

clear:
	$(DC) down

re: clear all

restart:
	$(DC) restart

# build:
# 	docker build -t $(NGINX_IMG) -f $(NGINX_DF) .
	