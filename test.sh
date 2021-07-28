#!/bin/bash

docker-compose -f examples/example/docker-compose.yml up --build
docker-compose -f examples/cpp_starter_project/docker-compose.yml up --build
docker-compose -f examples/web-example/docker-compose.yml up --build
docker-compose -f examples/android-example/docker-compose.yml up --build