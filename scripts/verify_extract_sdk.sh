#!/usr/bin/env bash

COSIGN_EXPERIMENTAL=1

python3 "$(dirname $0)/verify_extract_sdk.py" $1 $2 $PWD