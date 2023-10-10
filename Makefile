
DC_FILE := ./srcs/docker-compose.yml
DC := docker-compose -f $(DC_FILE)

all:
	$(DC) up -d --build

clear:
	$(DC) down

fclear:
	$(DC) down --volumes --rmi local

re: fclear all

.PHONY: all clear fclear re
