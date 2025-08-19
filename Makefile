# Minimal color codes
END=\033[0m
REV=\033[7m
GREY=\033[30m
RED=\033[31m
GREEN=\033[32m
YELLOW=\033[33m
CYAN=\033[36m
WHITE=\033[37m

NAME=inception

all: $(NAME)

$(NAME): build
	@$(MAKE) up

build:
	@echo "${YELLOW}> Image building${END}"
	@mkdir -p ${HOME}/data/wordpress
	@mkdir -p ${HOME}/data/mariadb
	@mkdir -p ${HOME}/data/adminer
	@docker compose -f ./srcs/docker-compose.yml build

up:
	@echo "${YELLOW}> Turning up images${END}"
	@docker compose -f ./srcs/docker-compose.yml up -d

down:
	@echo "${YELLOW}> Turning down images${END}"
	@docker compose -f ./srcs/docker-compose.yml down

re: down clean build up

clean: down
	@echo "${YELLOW}> Cleaning and deleting all volumes${END}"
	@docker ps -a -q | xargs -r docker rm -f
	@docker volume ls -q | xargs -r docker volume rm --force
	@sudo rm -rf ${HOME}/data/


.PHONY: all re down clean up build
