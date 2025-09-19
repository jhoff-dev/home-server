
# Start the Docker services
up:
	sh -c "cd docker/$(path) && ${DOCKER_COMPOSE} up -d"

# Destroy the Docker services
destroy:
	sh -c "cd docker/$(path) && ${DOCKER_COMPOSE} down --volumes"