all: build up

build:
	docker compose -f ./docker-compose.yml build

up:
	docker compose -f ./docker-compose.yml up -d

go:
	docker exec -it -w /root cluster-tool /bin/zsh

down:
	docker compose -f ./docker-compose.yml down
	docker compose -f ./docker-compose.yml down -v
	docker compose -f ./docker-compose.yml down --rmi all -v

clean: down

fclean: down
	docker system prune -a --volumes -f

re: fclean all

.PHONY: all build up go down clean fclean re
