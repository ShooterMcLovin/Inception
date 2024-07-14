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

run: dir
	sudo docker-compose $(NAME) $(COMPOSE_FILE) up

compose: dir
	sudo docker-compose $(NAME) $(COMPOSE_FILE) up --build -d

fclean: down clean
	sudo docker system prune -f
	sudo docker volume prune -f
	sudo docker image prune -a
	sudo docker volume rm -f inception_mariadb_data
	sudo docker volume rm -f inception_wordpress_data

clean:
	sudo rm -rf /home/$(USER)/data/mariadb
	sudo rm -rf /home/$(USER)/data/wordpress

attach-wp:
	sudo docker exec -it wordpress sh

attach-maria:
	sudo docker exec -it mariadb sh

attach-nginx:
	sudo docker exec -it nginx sh

dir:
	mkdir -p /home/$(USER)/data/mariadb
	mkdir -p /home/$(USER)/data/wordpress
	sudo chmod 777 /home/$(USER)/data/mariadb
	sudo chmod 777 /home/$(USER)/data/wordpress

re: clean compose

down:
	docker-compose $(COMPOSE_FILE) down -v