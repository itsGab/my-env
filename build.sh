#!/bin/bash
set -e

if ! command -v docker &> /dev/null; then
    echo "Erro: Docker não encontrado"
    exit 1
fi

docker build \
    --build-arg USER_UID=$(id -u) \
    --build-arg USER_GID=$(id -g) \
    --no-cache \
    -t devenv .

echo "Build concluído com sucesso"
