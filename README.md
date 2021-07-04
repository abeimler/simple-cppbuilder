# Simple C++ Docker Builder

Simple C++ Builder with gcc/clang, cmake and dependency manager (conan and/or vcpkg).

## Features

- Pre-installed Compilers and Tools
- Ready to use build scripts ([docker-build.sh]() and [docker-test.sh]())

## What's included

Base Image: [archlinux:base-devel](https://hub.docker.com/_/archlinux) with [yay](https://github.com/Jguer/yay).

- **Compilers:** clang, gcc or mingw-w64 (soon)
- **Buildtools:** cmake, make and ninja
- **Dependency Manager:** conan and/or vcpkg
- **More Tools:** python, pip, ccache, cppcheck, doxygen and more

## Environment Variables

`CC`

C Compiler, default:  `gcc`.
Can also be `clang`  

`CXX`

C++ Compiler, default:  `g++`.
Can also be `clang++`  

`CMAKE_GENERATOR`

CMake Generator `cmake -G`, default: `Ninja`.
Can also be `Unix Makefiles`  

`BUILD_TYPE`

CMake BuildType `-DCMAKE_BUILD_TYPE`, default: `Release`.
Can also be `Debug`, `RelWithDebInfo` or `MinSizeRel`.  

`TARGET`

target run by cmake `cmake --target`, default: `all`.  

`TOOLCHAIN_FILE`

CMake Toolchain File `-DCMAKE_TOOLCHAIN_FILE`, default `./vcpkg/scripts/buildsystems/vcpkg.cmake`.  

`CMAKE_ARGS`

Custom CMake Arguments, e.g. `-DENABLE_COVERAGE:BOOL=TRUE`.  

## Example

You can find a full C++ project example [here]().

### Simple Dockerfile in your C++-Project

```Dockerfile
FROM abeimler/simple-cppbuilder as build
COPY . .
CMD ["./docker-build.sh"]

## test stage
FROM build as test
CMD ["./docker-test.sh"]
```

### Dockerfile with more dependencies

```Dockerfile
FROM abeimler/simple-cppbuilder as build

RUN pacman-db-upgrade && pacman -S --noconfirm  \
    glu glfw raylib

COPY . .
CMD ["./docker-build.sh"]

## test stage
FROM build as test
CMD ["./docker-test.sh"]
```

### Dockerfile using AUR

```Dockerfile
FROM abeimler/simple-cppbuilder as build

# install android-sdk and android-ndk
RUN runuser -l yay -c \
    "yay -Syu --noconfirm && yay -S --noconfirm \
      android-sdk android-ndk"

COPY . .
CMD ["./my-android-build.sh"]
```

### Using docker-compose, build

```yml
version: "3.9"
services:
  # gcc Debug with Ninja
  gcc-debug-build:
    build:
      context: .
      dockerfile: Dockerfile
      target: build
    environment:
      CC: gcc
      CXX: g++
      TARGET: all
      BUILD_TYPE: Debug
      CMAKE_GENERATOR: Ninja
```

### Using docker-compose, run tests

```yml
version: "3.9"
services:
  # gcc Debug with Ninja
  gcc-debug-build:
    build:
      context: .
      dockerfile: Dockerfile
      target: test
    environment:
      CC: gcc
      CXX: g++
      TARGET: all
      BUILD_TYPE: Debug
      CMAKE_GENERATOR: Ninja
```

### Use your custom build script

#### `arm-build.sh`

```bash
#!/bin/bash

mkdir build
cd build
cmake -G "Unix Makefiles" -DCMAKE_SYSTEM_NAME=Linux -DCMAKE_SYSTEM_PROCESSOR=arm -DCMAKE_C_COMPILER=clang -DCMAKE_C_COMPILER_TARGET=arm-linux-gnueabihf -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_CXX_COMPILER_TARGET=arm-linux-gnueabihf ..

make my-app -j 4
```

#### `Dockerfile`

```Dockerfile
## base image
FROM abeimler/simple-cppbuilder as base

## build stage
FROM base as build
COPY . .
CMD ["./arm-build.sh"]
```

#### `docker-compose.yml`

```yml
---
version: "3.9"
services:
  my-app-build:
    build:
      context: .
      dockerfile: Dockerfile
      target: build
```

Run `docker-compose up`.

## Links

 - https://github.com/lefticus/cpp_starter_project
 - https://github.com/ricejasonf/cppdock