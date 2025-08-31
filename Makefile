
all:
	cd secrets/srcs && docker compose up --build
down:
	docker compose down
clean:
	docker compose down --rmi all -v --remove-orphans
fclean:
	docker compose down --rmi all -v --remove-orphans
	docker system prune -a --volumes