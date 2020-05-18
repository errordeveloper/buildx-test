#!/bin/bash

# Copyright 2017-2020 Authors of Cilium
# SPDX-License-Identifier: Apache-2.0

set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

git clone --branch llvmorg-10.0.0 https://github.com/llvm/llvm-project.git --reference /src/llvm.git /src/llvm
