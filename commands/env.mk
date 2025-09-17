# Necessary to avoid errors in commands with parameters.
%:
	@:

include .env

# Exports user and group IDs for use within docker containers
export UID=$(shell id -u)
export GID=$(shell id -g)
export DOCKER_HOST_GID=$(shell getent group docker | cut -d: -f3)

DOCKER_COMPOSE = docker compose -f docker-compose.yml --env-file .env