UID := $(shell id -u)
GID := $(shell id -g)

setup/mirakurun:
	env UID=${UID} GID=${GID} docker-compose run --rm -e SETUP=true mirakurun

start:
	env UID=${UID} GID=${GID} docker-compose up -d

down:
	docker-compose down

down/all:
	docker-compose down --rmi all --volumes --remove-orphans

update/mirakurun:
	docker-compose pull
	$(MAKE) start

update/epgstation:
	env UID=${UID} GID=${GID} docker-compose build --pull
	$(MAKE) start

update:
	docker-compose pull
	env UID=${UID} GID=${GID} docker-compose build --pull
	$(MAKE) start
