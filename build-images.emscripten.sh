#!/bin/bash

docker build --force-rm=true -f ./Dockerfile.emscripten -t abeimler/simple-cppbuilder:emscripten .
