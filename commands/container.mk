
# Start the Docker services
up:
	sh -c "cd docker/$(path) && ${DOCKER_COMPOSE} up -d"

# Destroy the Docker services
destroy:
	sh -c "cd docker/$(path) && ${DOCKER_COMPOSE} down --volumes"

# Start all server containers
up-all:
	make up path=cloudflare-tunnel
	make up path=github-runner
	make up path=web/nginx
	make up path=web/otel
	make up path=web/jhoff.site