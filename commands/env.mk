# Necessary to avoid errors in commands with parameters.
%:
	@:

include .env

DOCKER_COMPOSE = docker compose -f docker-compose.yml --env-file .env