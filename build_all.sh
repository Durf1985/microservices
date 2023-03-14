#!/usr/bin/env bash
export USER_NAME=fallgeratoor
for i in ui post-py comment; do
    cd src/$i || exit
    bash docker_build.sh; cd - || exit
done
