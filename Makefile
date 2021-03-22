COMPOSE=UID=${UID} GID=${GID} docker-compose

start/mirakurun:
	$(COMPOSE) run --rm -e SETUP=true mirakurun
start:
	UID=${UID} GID=${GID} docker-compose up -d
stop:
	$(COMPOSE) down
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
