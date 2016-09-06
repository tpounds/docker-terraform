DOCKER_IMAGE_TAG:=v0.7.3
DOCKER_IMAGE_NAME:=tpounds/terraform

default: build

build: Dockerfile docker-gc docker-version
	@echo "--- Building Image ---"
	docker build --file Dockerfile --rm --tag $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) .
	@echo ""

docker-gc: docker-gc-containers docker-gc-images

docker-gc-containers: docker-version
	@echo "--- Cleanup Exited Containers ---"
	$(eval DOCKER_EXITED_CONTAINERS:=$(shell docker ps -f status=exited -q | head))
	@if [ -n "$(DOCKER_EXITED_CONTAINERS)" ]; then docker rm -v $(DOCKER_EXITED_CONTAINERS); fi
	@echo ""

docker-gc-images: docker-version
	@echo "--- Cleanup Dangling Images ---"
	$(eval DOCKER_DANGLING_IMAGES=$(shell docker images -q -f dangling=true | head))
	@ if [ -n "$(DOCKER_DANGLING_IMAGES)" ]; then docker rmi $(DOCKER_DANGLING_IMAGES) || exit 0; fi
	@echo ""

docker-version:
	@echo "--- Docker Version ---"
	docker version
	@echo ""

push: build
	@echo "--- Pushing Image ---"
	docker push $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)
	@echo ""

release: build test push

run: build
	@echo "--- Running Image ---"
	docker run --rm --tty --interactive --entrypoint /bin/sh $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)
	@echo ""

test: build
