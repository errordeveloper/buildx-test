FROM errordeveloper/llvm-builder:b6c646e9b2ded27146d9c6645db262fa84546a32 as builder

COPY checkout-llvm.sh /tmp/checkout-llvm.sh
RUN /tmp/checkout-llvm.sh

COPY build-llvm-native.sh /tmp/build-llvm-native.sh
RUN /tmp/build-llvm-native.sh

COPY build-llvm-cross-aarch64.sh /tmp/build-llvm-cross-aarch64.sh
RUN /tmp/build-llvm-cross-aarch64.sh
