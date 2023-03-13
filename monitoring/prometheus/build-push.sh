#!/usr/bin/env bash
eval "$(docker-machine env docker-host)"
docker build -t fallgeratoor/prometheus:2.37.6 .
docker push fallgeratoor/prometheus:2.37.6
