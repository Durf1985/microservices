#!/usr/bin/env bash

eval "$(docker-machine env docker-host)"

docker build -t fallgeratoor/blackbox:0.23.0 ./monitoring/blackbox/
docker push fallgeratoor/blackbox:0.23.0

docker build -t fallgeratoor/prometheus:2.37.6 ./monitoring/prometheus/
docker push fallgeratoor/prometheus:2.37.6

docker-compose --env-file docker/.env -f docker/docker-compose.yml down
docker-compose --env-file docker/.env -f docker/docker-compose.yml up -d
