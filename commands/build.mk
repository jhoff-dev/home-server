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

build-runner:
	export UID=$(shell id -u)
	export GID=$(shell id -g)
	export DOCKER_HOST_GID=$(shell getent group docker | cut -d: -f3)
	docker compose build github-runner