#!/bin/bash -ue

if [ $# -lt 3 ]; then
    echo "Usage: $0 <docker-image> <entrypoint> <opam-packages>"
    exit 1
fi

BASE_IMAGE=DockerOpam/base

# Build the base image
if [ -z "$(docker images -q $BASE_IMAGE)" ]; then
    docker build -t $BASE_IMAGE base
fi

DOCKER_IMAGE=$1; shift
ENTRYPOINT=$1; shift
PACKAGES=("$@")

mkdir -p build && cd build
if [ ! -d opam-repository ]; then
    git clone https://github.com/ocaml/opam-repository
    cd opam-repository
else
    cd opam-repository
    git pull
    #git clean -fdx
fi
opam-admin make --resolve ${PACKAGES[@]}
cd ..

cat >Dockerfile <<EOF
FROM $BASE_IMAGE
ADD opam-repository /home/opam/opam-repository
RUN opam init /home/opam/opam-repository
RUN opam-installext ${PACKAGES[@]}
CMD ["$ENTRYPOINT"]
EOF

cd ..
docker build -t "$DOCKER_IMAGE" build
