FROM docker.io/library/ubuntu:20.04 as builder

COPY install-deps.sh /tmp/install-deps.sh
RUN /tmp/install-deps.sh

COPY clone-llvm.sh /tmp/clone-llvm.sh
RUN /tmp/clone-llvm.sh
