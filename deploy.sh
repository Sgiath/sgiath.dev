#!/usr/bin/env bash

REF=$(git rev-parse --short HEAD)

docker build \
	--tag "sgitah/sgiath.dev:${REF}" \
	--tag "sgiath/sgiath.dev:latest" \
	.

docker push "sgiath/sgiath.dev:${REF}"
docker push "sgiath/sgiath.dev:latest"

ssh sgiath.local 'cd /data/server && docker compose -f sgiath.yaml pull && docker compose -f sgiath.yaml up -d'
