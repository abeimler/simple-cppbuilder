# Simple C++ Docker Builder

<a href="https://hub.docker.com/r/abeimler/simple-cppbuilder">![logo](https://raw.githubusercontent.com/abeimler/simple-cppbuilder/main/img/logo.png)</a>  

![docker-image-size](https://img.shields.io/docker/image-size/abeimler/simple-cppbuilder) ![automated](https://img.shields.io/docker/automated/abeimler/simple-cppbuilder) ![pulls](https://img.shields.io/docker/pulls/abeimler/simple-cppbuilder) ![license](https://img.shields.io/github/license/abeimler/simple-cppbuilder) ![stars](https://img.shields.io/docker/stars/abeimler/simple-cppbuilder)

Simple C++ Builder with compilers, buildtools and dependency manager.

## Features

- Pre-installed Compilers and Tools
- Ready to use ~~build scripts ([docker-build.sh](https://github.com/abeimler/simple-cppbuilder/blob/main/scripts/docker-build.sh) and [docker-test.sh](https://github.com/abeimler/simple-cppbuilder/blob/main/scripts/docker-test.sh))~~ [Taskfiles](https://github.com/abeimler/simple-cppbuilder/blob/main/taskfiles/TaskfileDefault.sh)

## What's included

Based on [archlinux:base-devel](https://hub.docker.com/_/archlinux) with [yay](https://github.com/Jguer/yay).

- **Compilers:** [clang](https://llvm.org/), [gcc](https://gcc.gnu.org/) or cross-compiler
- **Buildtools:** [cmake](https://cmake.org/), make and ninja
- **Dependency Manager:** [conan](https://conan.io/) and/or [vcpkg](https://vcpkg.io/en/index.html)
- **More Tools:** python, pip, ccache, cppcheck, doxygen and more

## How to use this image

You can find a full C++ project example [here](https://github.com/abeimler/simple-cppbuilder/tree/main/examples/example).

### Add Docker into your C++ Project

1. Create a `Dockerfile` in your C++ project

```Dockerfile
## build stage
FROM abeimler/simple-cppbuilder as build
COPY . .
CMD ["task", "-t", "/home/taskfiles/Taskfile.yml", "build"]

## test stage
FROM build as test
CMD ["task", "-t", "/home/taskfiles/Taskfile.yml", "test"]
```

2. Build and run the Docker image:

```bash
$ docker build -t my-cpp-project .
$ docker run -it --rm --name my-app my-cpp-project
```

### Run a single file

```bash
$ docker run -it --rm --name my-cpp-project -v "$PWD":/home/project -w /home/project abeimler/simple-cppbuilder ./docker-build.sh
```

## Image Variants

### `:base`

Base image with gcc, buildtools and [conan](https://conan.io/) (dependency manager) installed.

### `:<version>`, `:latest`

Default image with gcc, buildtools, [conan](https://conan.io/) installed and [vcpkg](https://vcpkg.io/) bootstrapped.

### Compilers

#### `:clang`

Default image with clang compiler.

#### `:gcc10`, `:gcc9` (outdated)

Default image with gcc compiler.

### Libraries

#### `:libcpp`

Default image with clang and [libc++](https://libcxx.llvm.org/) installed.

#### `:boost`

Default image with [boost](https://www.boost.org/) installed.

#### `:abseil-cpp`

Default image with [abseil](https://abseil.io/) installed.

#### `:opengl-libs`

Default image with some OpenGL dependencies: `mesa glu glfw-x11 libx11 libxrender libxext libxcursor libxrandr libxinerama xorg-server-devel`.


### Misc

#### `:ci`, `:ci-x64-mingw-w64`

Alternative Ubuntu-based image with basic compilers and tools.  
_Nice base image for CI/CD._

#### `:ci-setup-cpp`

Alternative Ubuntu-based image with basic compilers and tools.  
_Uses [setup-cpp](https://github.com/aminya/setup-cpp)._


### Cross-Compiler (experimental)

_Not fully tested_

#### `:x64-mingw-w64`, `:x86-mingw-w64`

Default image with mingw-w64-cross-compiler: [mingw-w64-gcc](https://archlinux.org/packages/community/x86_64/mingw-w64-gcc/) and toolchain.

#### `:x64-mingw-w64-mxe`, `x86-mingw-w64-mxe`, `:x64-mingw-w64-mxe-static`, `:x86-mingw-w64-mxe-static` (older compiler)

Default image with [mxe](https://mxe.cc/) and toolchain.

#### `:emscripten`

Default image with [emscripten](https://emscripten.org/).

#### `:rpi4`, `:rpi3`,  `:rpi2`, `:rpi1`

Default image with arm-cross-compiler: ([crosstool-ng](https://crosstool-ng.github.io/)) for RaspberryPi, raspberrypi-tools and toolchain.

#### `:arm-android`, `:arm64-android`, `:x86-android`, `:x64-android`

Default image with [android-ndk](https://aur.archlinux.org/packages/android-ndk/) and toolchain.

## More Examples

### Dockerfile with system dependencies

```Dockerfile
FROM abeimler/simple-cppbuilder as base

RUN pacman-db-upgrade && pacman -S --noconfirm  \
    qt5-base qt5-base-util 

# build stage
FROM base as build
COPY . .
CMD ["task", "-t", "/home/taskfiles/Taskfile.yml", "build"]
```

### Dockerfile using AUR

```Dockerfile
FROM abeimler/simple-cppbuilder as base

# install android-sdk and android-ndk
RUN runuser -l yay -c \
    "yay -Syu --noconfirm && yay -S --noconfirm \
      android-sdk android-ndk"

# build stage
FROM base as build
COPY . .
CMD ["./my-android-build.sh"]
```

### Using docker-compose for build

```yml
version: '3.4'

services:
  # gcc Release with Ninja
  gcc-release-build:
    build:
      context: .
      dockerfile: Dockerfile
      target: build
    environment:
      CC: gcc
      CXX: g++
      TARGET: all
      BUILD_TYPE: Release
      CMAKE_GENERATOR: Ninja
```

```bash
$ docker-compose up --build
```

### Using docker-compose for testing

```yml
version: '3.4'

services:
  # gcc Debug with Ninja
  gcc-debug-test:
    build:
      context: .
      dockerfile: Dockerfile
      target: test
    environment:
      TARGET: all
      BUILD_TYPE: Debug
      CMAKE_GENERATOR: Ninja
```

```bash
$ docker-compose up --build
```

### ~~Use your custom build script~~ Better use a [Taskfile](https://taskfile.dev/usage/)

#### ~~`my-build.sh`~~

#### `Taskfile.yml`

```yml
---
version: "3"

vars:
  PROJECT_DIR: '{{.PROJECT_DIR | default "."}}'
  TARGET: '{{.TARGET | default "all"}}'
  CMAKE_GENERATOR: '{{.CMAKE_GENERATOR | default "Ninja Multi-Config"}}'
  BUILD_TYPE: '{{.BUILD_TYPE | default "Release"}}'

tasks:
  configure:
    dir: '{{.PROJECT_DIR}}'
    cmds:
      - >
        cmake -B build -S . -G "{{.CMAKE_GENERATOR}}" \
            -DCMAKE_BUILD_TYPE="{{.BUILD_TYPE}}" \
            {{.CMAKE_ARGS}}

  build:
    dir: '{{.PROJECT_DIR}}'
    cmds:
      - task: configure
      - 'cmake --build build --target "{{.TARGET}}"'

  test:
    dir: '{{.PROJECT_DIR}}'
    cmds:
      - task: build
      - ctest --build-test --test-dir build

```

#### `Dockerfile`

```Dockerfile
# base image
FROM abeimler/simple-cppbuilder as base

# build stage
FROM base as build
COPY . .
#CMD ["./my-build.sh"]
CMD ["task", "build"]
```

#### `docker-compose.yml`

```yml
---
version: '3.4'

services:
  my-app-build:
    build:
      context: .
      dockerfile: Dockerfile
      target: build
```

```bash
$ docker-compose up --build
```


## Environment Variables

### `CC`

C Compiler, default:  `gcc`.
Can also be `clang`.  

### `CXX`

C++ Compiler, default:  `g++`.
Can also be `clang++`.  

### `CMAKE_GENERATOR`

CMake Generator `cmake -G`, default: `Ninja`.
Can also be `Unix Makefiles`.  

### `BUILD_TYPE`

CMake BuildType `-DCMAKE_BUILD_TYPE`, default: `Release`.
Can also be `Debug`, `RelWithDebInfo` or `MinSizeRel`.  

### `TARGET`

target run by cmake `cmake --target`, default: `all`.  

### `TOOLCHAIN_FILE`

CMake Toolchain File `-DCMAKE_TOOLCHAIN_FILE`, default `./vcpkg/scripts/buildsystems/vcpkg.cmake`.  

### `CMAKE_ARGS`

Custom CMake Arguments, e.g. `-DENABLE_TESTING:BOOL=ON -DOPT_ENABLE_COVERAGE:BOOL=ON -DENABLE_DEVELOPER_MODE:BOOL=OFF`.  


## More Environment Variables

Here are some Environment Variables you can use in your build script, such as paths, scripts and programs.

### `MAKE`

`make` or `ninja`.

### `PROJECT_DIR`

Project-Home folder, `/home/project`.

### `VCPKG_ROOT`

Path to vcpkg, `/home/project/vcpkg`.

### `VCPKG_TOOLCHAIN_FILE`

vcpkg Toolchain, `/home/project/vcpkg/scripts/buildsystems/vcpkg.cmake`.


### `CODECOV`

Path to [codedov uploader](https://about.codecov.io/blog/introducing-codecovs-new-uploader/), `/home/codecov/codecov`.

_(Used in CI/CD images)_


### `VCPKG_DEFAULT_HOST_TRIPLET`, `VCPKG_DEFAULT_TRIPLET`

vcpkg target- and host-triplet.

_(Used in cross-compiler images)_

### `VCPKG_CHAINLOAD_TOOLCHAIN_FILE`

alternate CMake toolchain (for vcpkg)

_(Used in cross-compiler images)_

### `CROSS_TOOLCHAIN`

Path to CMake Toolchain, `/home/cmake/x86_64-w64-mingw32.toolchain.cmake`.

_(Used in cross-compiler images)_

### `SETUP_ENV_SCRIPT`

source or setup-environment-script for cross compiler tools, `/usr/lib/emsdk/emsdk_env.sh` or `	~/.cpprc`, ...

_(Used in cross-compiler images)_

### `EM_CACHE`, `EM_CONFIG`, `EMSCRIPTEN_PATH`, `EMSDK`, `EMSDK_PATH`

Paths for emscripten, emsdk and configs.

* `EM_CACHE`: `/usr/lib/emsdk/upstream/emscripten/cache`
* `EM_CONFIG`: `/usr/lib/emsdk/.emscripten`
* `EMSCRIPTEN_PATH`: `/usr/lib/emscripten`
* `EMSDK`: `/usr/lib/emsdk`
* `EMSDK_PATH`: `/usr/lib/emsdk`

_(Used in emscripten images)_


## License

View [license information](https://github.com/abeimler/simple-cppbuilder/blob/main/LICENSE) for this image.  

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).  

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.


### Links

- [simple-cppbuilder DockerHub](https://hub.docker.com/r/abeimler/simple-cppbuilder)
- [simple-cppbuilder GitHub](https://github.com/abeimler/simple-cppbuilder)
- [cpp_starter_project](https://github.com/lefticus/cpp_starter_project)
- [cpp_vcpkg_project](https://github.com/abeimler/cpp_vcpkg_project/tree/v2)
- [cppdock](https://github.com/ricejasonf/cppdock)
- Icon made by [me](https://hub.docker.com/u/abeimler) using C++-Icon made by [Freepik](https://www.freepik.com) from [Flaticon](https://www.flaticon.com/)
