#!/bin/bash

## install https://github.com/GoogleContainerTools/container-structure-test

container-structure-test test --image abeimler/simple-cppbuilder:base --config tests/base-test.yaml

container-structure-test test --image abeimler/simple-cppbuilder --config tests/test.yaml
container-structure-test test --image abeimler/simple-cppbuilder:without-vcpkg --config tests/without-vcpkg-test.yaml

container-structure-test test --image abeimler/simple-cppbuilder:ci --config tests/ci-test.yaml
container-structure-test test --image abeimler/simple-cppbuilder:ci-x64-mingw-w64 --config tests/ci-windows-test.yaml
container-structure-test test --image abeimler/simple-cppbuilder:ci-setup-cpp --config tests/ci-setup-cpp-test.yaml

container-structure-test test --image abeimler/simple-cppbuilder:clang --config tests/clang-test.yaml

container-structure-test test --image abeimler/simple-cppbuilder:emscripten --config tests/emscripten-test.yaml


container-structure-test test --image abeimler/simple-cppbuilder:gcc-10 --config tests/gcc10-test.yaml
container-structure-test test --image abeimler/simple-cppbuilder:gcc-9 --config tests/gcc9-test.yaml

container-structure-test test --image abeimler/simple-cppbuilder:x64-mingw-w64 --config tests/mingw-test.yaml
container-structure-test test --image abeimler/simple-cppbuilder:x64-mingw-w64-mxe --config tests/mxe-test.yaml

container-structure-test test --image abeimler/simple-cppbuilder:aarch64-linux --config tests/aarch64-test.yaml

container-structure-test test --image abeimler/simple-cppbuilder:arm-android --config tests/arm-android-test.yaml

container-structure-test test --image abeimler/simple-cppbuilder:rpi4 --config tests/rpi4-test.yaml



docker-compose -f examples/example/docker-compose.yml up --build example-gcc-debug-build-make example-gcc-debug-build
docker-compose -f examples/example/docker-compose.yml up --build example-gcc-debug-test
docker-compose -f examples/example/docker-compose.yml up --build example-gcc-release-build example-gcc-release-test
docker-compose -f examples/example/docker-compose.yml up --build example-clang-debug-build example-clang-debug-test
docker-compose -f examples/example/docker-compose.yml up --build example-clang-release-build example-clang-release-test
docker-compose -f examples/example/docker-compose.yml up --build example-gcc-debug-test-cov
docker-compose -f examples/example/docker-compose.yml up --build example-gcc-debug-test-lcov
docker-compose -f examples/example/docker-compose.yml up --build example-gcc-release-with-raylib
docker-compose -f examples/example/docker-compose.yml down --volumes --rmi local

docker-compose -f examples/example-ci/docker-compose.yml up --build example-gcc-build example-gcc-test example-gcc-test-cov
docker-compose -f examples/example-ci/docker-compose.yml up --build example-windows-build
docker-compose -f examples/example-ci/docker-compose.yml down --volumes --rmi local

docker-compose -f examples/example/docker-compose.cross.yml up --build example-mingw-release-build
docker-compose -f examples/example/docker-compose.cross.yml up --build example-arm64-release-build
docker-compose -f examples/example/docker-compose.cross.yml up --build example-rpi4-release-build
docker-compose -f examples/example/docker-compose.cross.yml down --volumes --rmi local

docker-compose -f examples/cpp_starter_project/docker-compose.yml up --build
docker-compose -f examples/cpp_starter_project/docker-compose.yml down --volumes --rmi local

docker-compose -f examples/web-example/docker-compose.yml up --build
docker-compose -f examples/web-example/docker-compose.yml down --volumes --rmi local

docker-compose -f examples/android-example/docker-compose.yml up --build
docker-compose -f examples/android-example/docker-compose.yml down --volumes --rmi local

docker run -it --rm --name my-cpp-project -v "$PWD/examples/single":/home/project -w /home/project abeimler/simple-cppbuilder ./docker-build.sh
docker run -it --rm --name my-cpp-project -v "$PWD/examples/single":/home/project -w /home/project abeimler/simple-cppbuilder-ci ./docker-build.sh
docker run -it --rm --name my-cpp-project -v "$PWD/examples/single":/home/project -w /home/project abeimler/simple-cppbuilder-setup-cpp ./docker-build.sh
