#!/bin/bash
set -e # Any subsequent(*) commands which fail will cause the shell script to exit immediately

# Create/use a builder that supports multi-platform
docker buildx create --name multiarch --driver docker-container --use 2>/dev/null || docker buildx use multiarch

pkgV=`node -e "console.log(require('./package.json').version.trim())"`
specificVersionTag=cornerhealth/interval-server:$pkgV

# Build the docker image + push to registry (multi-platform)
docker buildx build --push --platform linux/amd64,linux/arm64 \
  -t cornerhealth/interval-server:latest \
  -t $specificVersionTag .