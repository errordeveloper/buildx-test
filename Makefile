MAKER_IMAGE_NAME := errordeveloper/maker
MAKER_IMAGE_TAG := $(shell images/make-image-tag.sh images/maker)
MAKER_IMAGE := $(MAKER_IMAGE_NAME):$(MAKER_IMAGE_TAG)

build-maker-image:
	docker buildx build --tag $(MAKER_IMAGE) images/maker

push-maker-image: build-maker-image
	docker image push $(MAKER_IMAGE)

update-maker-image:
	for i in .github/workflows/*.yaml ; do \
          sed "s|\($(MAKER_IMAGE_NAME)\):.*$$|\1:$(MAKER_IMAGE_TAG)|" "$${i}" > "$${i}.sedtmp" && mv "$${i}.sedtmp" "$${i}" ; \
        done

.buildx_builder:
	docker buildx create --platform linux/amd64,linux/arm64 > $@

build-example-app-image: .buildx_builder
	docker buildx build \
	  --platform linux/amd64,linux/arm64 \
	  --builder "$$(cat .buildx_builder)" \
	  --output "type=image,push=false" \
	  images/example-app
	docker buildx rm "$$(cat .buildx_builder)"
	rm -f .buildx_builder
