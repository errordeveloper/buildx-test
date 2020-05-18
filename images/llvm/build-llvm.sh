#!/bin/bash

# Copyright 2017-2020 Authors of Cilium
# SPDX-License-Identifier: Apache-2.0

set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

git clone --branch llvmorg-10.0.0 https://github.com/llvm/llvm-project.git --reference /src/llvm.git /src/llvm

mkdir -p /src/llvm/llvm/build/install

cd /src/llvm/llvm/build

cmake .. -G "Ninja" \
  -DLLVM_TARGETS_TO_BUILD="BPF" \
  -DLLVM_ENABLE_PROJECTS="clang" \
  -DBUILD_SHARED_LIBS=OFF \
  -DCMAKE_BUILD_TYPE=Release \
  -DLLVM_BUILD_RUNTIME=OFF

ninja clang llc

strip bin/clang
strip bin/llc
