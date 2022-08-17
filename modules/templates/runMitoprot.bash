#!/usr/bin/env bash

set -euo pipefail
mitoprot \
    -f $params.formatType \
    -o summary subset.fa
