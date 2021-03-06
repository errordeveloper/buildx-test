ARG DOCKER_IMAGE=docker:19.03.8-dind@sha256:841b5eb000551dc3c30a46386ab4bfed5839ec9592c88e961236b25194ce88b9
ARG ALPINE_BASE_IMAGE=alpine:3.11.6@sha256:9a839e63dad54c3a6d1834e29692c8492d93f90c59c978c1ed79109ea4fb9a54

FROM ${DOCKER_IMAGE} as docker-dist 
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

ARG BUILDX_VERSION=0.4.1

RUN curl --silent --location \
      https://github.com/docker/buildx/releases/download/v${BUILDX_VERSION}/buildx-v${BUILDX_VERSION}.linux-amd64 \
    --output /out/usr/local/bin/docker-buildx \
    && chmod +x /out/usr/local/bin/docker-buildx

RUN mkdir -p /out/etc/docker/cli-plugins \
    && echo '{ "experimental": "enabled" }' > /out/etc/docker/config.json \
    && ln -fs /usr/local/bin/docker-buildx /out/etc/docker/cli-plugins

FROM scratch
ENV DOCKER_CONFIG=/etc/docker
COPY --from=builder /out /
