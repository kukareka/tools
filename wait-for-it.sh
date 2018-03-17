#!/usr/bin/env bash

os=$(uname -s | tr '[:upper:]' '[:lower:]')

./bin/$os/wait-for-it "$@"
