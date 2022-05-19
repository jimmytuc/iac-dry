#!/usr/bin/env bash

ACTION=$1

# find and clean the cache
find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} \;

terragrunt run-all ${ACTION}
