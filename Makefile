MAKER_IMAGE_NAME := errordeveloper/maker
MAKER_IMAGE_TAG := $(shell images/make-image-tag.sh images/maker)

build-maker-image:
	docker buildx build --tag $(MAKER_IMAGE_NAME):$(MAKER_IMAGE_TAG) images/maker

push-maker-image: build-maker-image
	docker image push $(MAKER_IMAGE_NAME):$(MAKER_IMAGE_TAG)
