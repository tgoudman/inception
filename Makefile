DOCKER_COMPOSE=docker compose

DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml

.PHONY: kill build down clean restart

build:
	sudo mkdir -p /home/tgoudman/data/mysql
	sudo mkdir -p /home/tgoudman/data/wordpress
	sudo mkdir -p /home/tgoudman/data/mariadb
	@$(DOCKER_COMPOSE)  -f $(DOCKER_COMPOSE_FILE) build --no-cache
	@$(DOCKER_COMPOSE)  -f $(DOCKER_COMPOSE_FILE) up --build -d
kill:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) kill
down:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down
clean:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down -v

fclean: clean
	chmod -R 777 ./srcs/data || true
	rm -rf ./srcs/data/mysql
	rm -rf ./srcs/data/wordpress
	rm -rf ./srcs/data/mariadb
	docker system prune -a -f

restart: clean build