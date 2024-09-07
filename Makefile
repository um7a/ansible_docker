IMAGE_NAME := um7a/ansible
TAG := 0.0.1
CONTAINER_NAME := $(shell echo ${IMAGE_NAME}_${TAG} | sed -e s/\\//_/g)

CONTAINER_EXISTS = "$(shell docker ps | grep ${CONTAINER_NAME})"

.PHONY: help
help:
	@echo ""
	@echo "  TARGETS"
	@echo "    build  ... Build docker image \"${IMAGE_NAME}\"."
	@echo "    clean  ... Clean docker image \"${IMAGE_NAME}\"."
	@echo "    run    ... Run docker container using image \"${IMAGE_NAME}\"."
	@echo "               If you want to mount a playbook directory, use \"PLAYBOOK_PATH=<path>\"."
	@echo "    attach ... Attach on docker container using image \"${IMAGE_NAME}\"."
	@echo "    stop   ... Stop docker container which was created by run target."
	@echo ""

.PHONY: build
build: Dockerfile
	docker build --rm -t ${IMAGE_NAME}:${TAG} .

.PHONY: clean
clean: stop
	docker rmi ${IMAGE_NAME}:${TAG}

.PHONY: run
run: stop
	@echo "Start test container."
ifneq (${PLAYBOOK_PATH}, "")
	docker run \
	-itd \
	--rm \
	--name ${CONTAINER_NAME} \
	-v ${PLAYBOOK_PATH}:/opt/playbook \
	${IMAGE_NAME}:${TAG}
else
	docker run \
	-itd \
	--rm \
	--name ${CONTAINER_NAME} \
	${IMAGE_NAME}:${TAG}
endif

.PHONY: attach
attach:
	# Execute bash
	docker exec \
	-it \
	${CONTAINER_NAME} \
	/bin/bash

.PHONY: stop
stop:
ifneq (${CONTAINER_EXISTS}, "")
	@echo "!!! Container exists. Stop. !!!"
	docker stop \
	${CONTAINER_NAME}
else
	@echo "Container does not exist."
endif
