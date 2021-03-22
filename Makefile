UID := $(shell id -u)
GID := $(shell id -g)

COMPOSE=env UID=${UID} GID=${GID} docker-compose

setup/mirakurun:
	$(COMPOSE) run --rm -e SETUP=true mirakurun

start:
	$(COMPOSE) up -d

stop:
	$(COMPOSE) stop

down:
	$(COMPOSE) down

down/all:
	$(COMPOSE) down --rmi all --volumes --remove-orphans

update/mirakurun:
	$(COMPOSE) pull
	$(MAKE) start

update/epgstation:
	$(COMPOSE) build --pull
	$(MAKE) start

update:
	$(COMPOSE) pull
	$(COMPOSE) build --pull
	$(MAKE) start
