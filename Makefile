#------------------------------------------------------------------------------#
#                                  GENERICS                                    #
#------------------------------------------------------------------------------#

# Special variables
DEFAULT_GOAL: compose
.PHONY: compose clean re


#------------------------------------------------------------------------------#
#                                VARIABLES                                     #
#------------------------------------------------------------------------------#

NAME			= -p inception
COMPOSE_FILE	= -f ./srcs/docker-compose.yml


#------------------------------------------------------------------------------#
#                                 TARGETS                                      #
#------------------------------------------------------------------------------#

run:
	sudo docker-compose $(NAME) $(COMPOSE_FILE) up

compose:
	mkdir -p /home/alpicard/data/mariadb
	mkdir -p /home/alpicard/data/wordpress
	sudo chmod 777 /home/alpicard/data/mariadb
	sudo chmod 777 /home/alpicard/data/wordpress
	sudo docker-compose $(NAME) $(COMPOSE_FILE) up --build

fclean: clean
	docker volume rm -f inception_mariadb_data
	docker volume rm -f inception_wordpress_data
clean:
	sudo rm -rf /home/alpicard/data/mariadb
	sudo rm -rf /home/alpicard/data/wordpress
	sudo docker system prune -f
	sudo docker volume prune -f

attach-wp:
	sudo docker exec -it wordpress sh

attach-maria:
	sudo docker exec -it mariadb sh

attach-nginx:
	sudo docker exec -it nginx sh

re: clean compose

down:
	docker-compose -f $(COMPOSE_FILE) down -v