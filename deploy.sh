#!/usr/bin/env bash

REF=$(git rev-parse --short HEAD)

docker build \
  --tag "sgitah/sgiath.dev:${REF}" \
  --tag "sgiath/sgiath.dev:latest" \
  .

docker push "sgiath/sgiath.dev:${REF}"
docker push "sgiath/sgiath.dev:latest"

ssh sgiath.dev 'cd /data/server && docker compose pull && docker compose restart sgiath'
