## base image
FROM abeimler/simple-cppbuilder:base AS base

# default compiler versions
ARG extra_libraries

# Install packages available from standard repos
RUN pacman-db-upgrade && \
    pacman -S --noconfirm --needed \
        wget curl pkg-config zip unzip tar git go && \
    pacman -S --noconfirm  \
        gcc binutils bison \
        ${extra_libraries} \
        cmake make ninja && \
    pacman -Scc --noconfirm


# set default compiler
ENV CC "gcc"
ENV CXX "g++"
ENV CMAKE "cmake"
ENV MAKE "make"

# build script settings
ENV TARGET "all"
ENV BUILD_TYPE "Release"
ENV CMAKE_GENERATOR "Ninja"
ENV CMAKE_ARGS ""


# setup project env
WORKDIR /home/project
COPY ./scripts/docker-build.sh ./docker-build.sh
COPY ./scripts/docker-test.sh ./docker-test.sh
COPY ./scripts/docker-test-coverage.sh ./docker-test-coverage.sh

# install vcpkg
ENV VCPKG_DISABLE_METRICS 1
RUN git clone --depth 1 https://github.com/Microsoft/vcpkg.git /home/project/vcpkg
RUN /home/project/vcpkg/bootstrap-vcpkg.sh -disableMetrics
ENV VCPKG_ROOT "/home/project/vcpkg"

ENV VCPKG_TOOLCHAIN_FILE "$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake"
ENV TOOLCHAIN_FILE "$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake"

RUN mkdir build