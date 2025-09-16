# Cloudflare Tunnels
up:
	sh -c "cd docker/cloudflare-tunnel && ${DOCKER_COMPOSE} up -d"

destroy:
	sh -c "cd docker/cloudflare-tunnel && ${DOCKER_COMPOSE} down --volumes"

# Github Runner
up:
	sh -c "cd docker/github-runner && ${DOCKER_COMPOSE} up -d"

destroy:
	sh -c "cd docker/github-runner && ${DOCKER_COMPOSE} down --volumes"