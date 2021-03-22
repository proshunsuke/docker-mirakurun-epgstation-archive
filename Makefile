UID := $(shell id -u)
GID := $(shell id -g)

setup/mirakurun:
	docker-compose run --rm -e SETUP=true -e UID=${UID} -e GID=${GID} mirakurun

start:
	docker-compose up -e UID=${UID} -e GID=${GID} -d

down:
	docker-compose down

down/all:
	docker-compose down --rmi all --volumes --remove-orphans

update/mirakurun:
	docker-compose pull
	$(MAKE) start

update/epgstation:
	docker-compose build -e UID=${UID} -e GID=${GID} --pull
	$(MAKE) start

update:
	docker-compose pull
	docker-compose build -e UID=${UID} -e GID=${GID} --pull
	$(MAKE) start
