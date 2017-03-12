
CONTAINER  := madness
IMAGE_NAME := docker-madness

build:
	docker build \
		--rm \
		--tag=$(IMAGE_NAME) .
	@echo Image tag: ${IMAGE_NAME}

clean:
	docker \
		rmi \
		${IMAGE_NAME}

run:
	docker run \
		--detach \
		--interactive \
		--tty \
		--publish=2222 \
		--hostname=${CONTAINER} \
		--name=${CONTAINER} \
		$(IMAGE_NAME)

shell:
	docker run \
		--rm \
		--interactive \
		--tty \
		--publish=2222:2222 \
		--hostname=${CONTAINER} \
		--name=${CONTAINER} \
		$(IMAGE_NAME)

exec:
	docker exec \
		--interactive \
		--tty \
		${CONTAINER} \
		/bin/sh

stop:
	docker kill \
		${CONTAINER}

history:
	docker history \
		${IMAGE_NAME}

