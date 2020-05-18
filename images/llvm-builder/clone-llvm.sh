#!/bin/bash

# Copyright 2017-2020 Authors of Cilium
# SPDX-License-Identifier: Apache-2.0

set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

mkdir /src

git clone --mirror --bare https://github.com/llvm/llvm-project.git /src/llvm.git
