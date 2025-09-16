# Cloudflare Tunnels
cloudflared-up:
	sh -c "cd docker/cloudflare-tunnel && ${DOCKER_COMPOSE} up -d"

cloudflared-destroy:
	sh -c "cd docker/cloudflare-tunnel && ${DOCKER_COMPOSE} down --volumes"

# Github Runner
runner-up:
	sh -c "cd docker/github-runner && ${DOCKER_COMPOSE} up -d"

runner-destroy:
	sh -c "cd docker/github-runner && ${DOCKER_COMPOSE} down --volumes"

runner-build:
	sh -c "export UID=$(shell id -u) && export GID=$(shell id -g) && export DOCKER_HOST_GID=$(shell getent group docker | cut -d: -f3) && docker compose build github-runner"