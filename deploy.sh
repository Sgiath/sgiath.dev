#!/usr/bin/env bash

docker build --tag sgiath .
docker save --output sgiath.tar sgiath
scp sgiath.tar sgiath.dev:/tmp
ssh sgiath.dev 'docker import /tmp/sgiath.tar sgiath && rm -f /tmp/sgiath.tar'
# ssh sgiath.dev 'cd /home/sgiath/docker && docker compose restart sgiath'
