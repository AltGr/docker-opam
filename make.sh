#!/bin/bash -ue

if [ $# -lt 2 ]; then
    echo "Usage: $0 <docker-image> <opam-packages>"
    exit 1
fi
DOCKER_IMAGE=$1; shift
echo "$*" >packages
PACKAGES=("$@")

git clone https://github.com/ocaml/opam-repository
cd opam-repository
opam-admin make --resolve ${PACKAGES[@]}
cd ..
docker build -t "$DOCKER_IMAGE" .
