all:
	mkdir -p /home/omar/data/mariadb
	mkdir -p /home/omar/data/wordpress
	cd secrets/srcs && docker compose up --build -d

down:
	cd secrets/srcs && docker compose down

clean:
	cd secrets/srcs && docker compose down --rmi all -v

fclean:
	cd secrets/srcs && docker compose down --rmi all -v
	sudo rm -rf /home/omar/data/mariadb
	sudo rm -rf /home/omar/data/wordpress

re: fclean all

.PHONY: all down clean fclean re