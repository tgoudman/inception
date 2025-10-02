DOCKER_COMPOSE=docker compose

DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml

.PHONY: kill build down clean restart

build:
	sudo mkdir -p /home/tgoudman/data/mysql
	sudo mkdir -p /home/tgoudman/data/wordpress
	sudo mkdir -p /home/tgoudman/data/mariadb
	@$(DOCKER_COMPOSE)  -f $(DOCKER_COMPOSE_FILE) build
	@$(DOCKER_COMPOSE)  -f $(DOCKER_COMPOSE_FILE) up --build -d
kill:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) kill
down:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down
clean:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down -v

fclean: clean
	chmod -R 777 /home/tgoudman/data || true
	sudo rm -rf /home/tgoudman/data/mysql
	sudo rm -rf /home/tgoudman/data/wordpress
	sudo rm -rf /home/tgoudman/data/mariadb
	docker system prune -f

restart: clean build