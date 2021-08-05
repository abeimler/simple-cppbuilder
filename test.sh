#!/bin/bash

container-structure-test test --image abeimler/simple-cppbuilder:base --config tests/base-test.yaml

container-structure-test test --image abeimler/simple-cppbuilder --config tests/test.yaml
container-structure-test test --image abeimler/simple-cppbuilder:without-vcpkg --config tests/without-vcpkg-test.yaml

container-structure-test test --image abeimler/simple-cppbuilder:clang --config tests/clang-test.yaml

container-structure-test test --image abeimler/simple-cppbuilder:emscripten --config tests/emscripten-test.yaml

container-structure-test test --image abeimler/simple-cppbuilder:x64-mingw-w64 --config tests/mingw-test.yaml
container-structure-test test --image abeimler/simple-cppbuilder:x64-mingw-w64-mxe --config tests/mxe-test.yaml

container-structure-test test --image abeimler/simple-cppbuilder:aarch64-linux --config tests/aarch64-test.yaml

container-structure-test test --image abeimler/simple-cppbuilder:arm-android --config tests/arm-android-test.yaml

container-structure-test test --image abeimler/simple-cppbuilder:rpi4 --config tests/rpi4-test.yaml

docker-compose -f examples/example/docker-compose.yml up --build
docker-compose -f examples/cpp_starter_project/docker-compose.yml up --build
docker-compose -f examples/web-example/docker-compose.yml up --build
docker-compose -f examples/android-example/docker-compose.yml up --build

docker run -it --rm --name my-cpp-project -v "$PWD/examples/single":/home/project -w /home/project abeimler/simple-cppbuilder ./docker-build.sh