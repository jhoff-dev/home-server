# --- Cloudflare Tunnels ---

# Start the Docker services
cloudflared-up:
	sh -c "cd docker/cloudflare-tunnel && ${DOCKER_COMPOSE} up -d"

# Destroy the Docker services
cloudflared-destroy:
	sh -c "cd docker/cloudflare-tunnel && ${DOCKER_COMPOSE} down --volumes"

# --- Github Runner ---

# Start the Docker services
runner-up:
	sh -c "cd docker/github-runner && ${DOCKER_COMPOSE} up -d"

# Destroy the Docker services
runner-destroy:
	sh -c "cd docker/github-runner && ${DOCKER_COMPOSE} down --volumes"

# Build the docker image used in the runner
runner-build:
	sh -c "cd docker/github-runner && export UID=$(shell id -u) && export GID=$(shell id -g) && export DOCKER_HOST_GID=$(shell getent group docker | cut -d: -f3) && docker compose build github-runner"