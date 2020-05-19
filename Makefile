PUSH ?= false

OUTPUT := "type=docker"
ifeq ($(PUSH),true)
OUTPUT := "type=registry,push=true"
endif

.buildx_builder:
	docker buildx create --platform linux/amd64,linux/arm64 > $@

MAKER_IMAGE_NAME := errordeveloper/maker
MAKER_IMAGE_TAG := $(shell images/make-image-tag.sh images/maker)
MAKER_IMAGE := $(MAKER_IMAGE_NAME):$(MAKER_IMAGE_TAG)

maker-image: .buildx_builder
	docker buildx build \
	  --platform linux/amd64 \
	  --builder "$$(cat .buildx_builder)" \
	  --tag $(MAKER_IMAGE) \
	  --output $(OUTPUT) \
	    images/maker

update-maker-image:
	for i in .github/workflows/*.yaml ; do \
          sed "s|\($(MAKER_IMAGE_NAME)\):.*$$|\1:$(MAKER_IMAGE_TAG)|" "$${i}" > "$${i}.sedtmp" && mv "$${i}.sedtmp" "$${i}" ; \
        done

LLVM_BUILDER_IMAGE_NAME := errordeveloper/llvm-builder
LLVM_BUILDER_IMAGE_TAG := $(shell images/make-image-tag.sh images/llvm-builder)
LLVM_BUILDER_IMAGE := $(LLVM_BUILDER_IMAGE_NAME):$(LLVM_BUILDER_IMAGE_TAG)

llvm-builder-image: .buildx_builder
	docker buildx build \
	  --platform linux/amd64 \
	  --builder "$$(cat .buildx_builder)" \
	  --tag $(LLVM_BUILDER_IMAGE) \
	  --output $(OUTPUT) \
	    images/llvm-builder

LLVM_IMAGE_NAME := errordeveloper/llvm
LLVM_IMAGE_TAG := $(shell images/make-image-tag.sh images/llvm)
LLVM_IMAGE := $(LLVM_IMAGE_NAME):$(LLVM_IMAGE_TAG)

llvm-image: .buildx_builder
	docker buildx build \
	  --platform linux/amd64 \
	  --builder "$$(cat .buildx_builder)" \
	  --tag $(LLVM_IMAGE) \
	  --output $(OUTPUT) \
	    images/llvm

example-app-image: .buildx_builder
	docker buildx build \
	  --platform linux/amd64,linux/arm64 \
	  --builder "$$(cat .buildx_builder)" \
	  --output $(OUTPUT) \
	    images/example-app
