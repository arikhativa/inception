
DC_FILE := ./srcs/docker-compose.yml
DC := docker compose -f $(DC_FILE)

all:
	$(DC) up -d --build

clear:
	$(DC) down

fclear:
	$(DC) down --volumes --rmi local

re: clear all

restart: 
	$(DC) restart

.PHONY: restart all clear fclear re
