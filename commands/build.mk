# Start the Docker services
up:
	${DOCKER_COMPOSE} up -d

# Stop the Docker services
stop:
	${DOCKER_COMPOSE} stop

# Destroy the Docker services
destroy:
	${DOCKER_COMPOSE} down --volumes

# Restart the Docker services
restart:
	${DOCKER_COMPOSE} restart

prune:
	docker system prune -a