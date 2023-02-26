include .env

IMAGE_NAME := 13rom/aegea
IMAGE_TAG := $(AEGEA_VERSION)
DOCKER_IMAGE := $(IMAGE_NAME):$(IMAGE_TAG)

PHONY_TARGETS = build push deploy
.PHONY: PHONY_TARGETS


build:
	docker build . --build-arg AEGEA_VERSION=$(AEGEA_VERSION) -t $(DOCKER_IMAGE)

push:
	docker push $(DOCKER_IMAGE)

deploy:
	docker compose up -d