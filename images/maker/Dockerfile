ARG DOCKER_IMAGE=docker:19.03.8-dind@sha256:841b5eb000551dc3c30a46386ab4bfed5839ec9592c88e961236b25194ce88b9
ARG ALPINE_BASE_IMAGE=alpine:3.11.6@sha256:9a839e63dad54c3a6d1834e29692c8492d93f90c59c978c1ed79109ea4fb9a54
ARG QEMU_USER_STATIC_AARCH64_IMAGE=multiarch/qemu-user-static:x86_64-aarch64@sha256:1f7e49680b2c4df563fca1ba95c3d1854c98f4b449823981301470dc58733832

ARG BUILDX_VERSION=0.4.1

FROM ${DOCKER_IMAGE} as docker-dist 
FROM ${QEMU_USER_STATIC_AARCH64_IMAGE} as qemu-dist
FROM ${ALPINE_BASE_IMAGE} as builder

RUN apk add --no-cache \
    curl \
    && true

RUN mkdir -p /out/etc/apk && cp -r /etc/apk/* /out/etc/apk/

RUN apk add --initdb --no-cache --root /out \
    alpine-baselayout \
    bash \
    ca-certificates \
    coreutils \
    git \
    make \
    && true

COPY --from=docker-dist /usr/local/bin /out/usr/local/bin
COPY --from=qemu-dist /usr/bin/qemu-aarch64-static /out/usr/local/bin/qemu-aarch64-static

RUN curl --silent --location \
      https://github.com/docker/buildx/releases/download/v${BUILDX_VERSION}/buildx-v${BUILDX_VERSION}.linux-amd64 \
    --output /out/usr/local/bin/docker-buildx \
    && chmod +x /out/usr/local/bin/docker-buildx

FROM scratch
ENV DOCKER_CLI_EXPERIMENTAL=enabled
COPY --from=builder /out /
