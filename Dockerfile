## base image
FROM abeimler/simple-cppbuilder:base as base

# default compiler versions
ARG extra_libraries

# Install packages available from standard repos
RUN pacman-db-upgrade && \
    pacman -Syyu --noconfirm && pacman-db-upgrade && \
    pacman -S --noconfirm --needed \
        wget curl pkg-config zip unzip tar git go && \
    pacman -S --noconfirm  \
        gcc binutils bison \
        ${extra_libraries} \
        cmake make ninja

# set default compiler
ENV CC "gcc"
ENV CXX "g++"
RUN $CC -v
RUN $CXX -v

# setup project env
WORKDIR /home/project
COPY ./scripts/docker-build.sh ./docker-build.sh
COPY ./scripts/docker-test.sh ./docker-test.sh

# install vcpkg
ENV VCPKG_DISABLE_METRICS 1
RUN git clone https://github.com/Microsoft/vcpkg.git
RUN ./vcpkg/bootstrap-vcpkg.sh -disableMetrics
ENV VCPKG_ROOT "/home/project/vcpkg"

# build script settings
ENV TARGET "all"
ENV BUILD_TYPE "Release"
ENV CMAKE_GENERATOR "Ninja"
ENV TOOLCHAIN_FILE "/home/project/vcpkg/scripts/buildsystems/vcpkg.cmake"
ENV CMAKE_ARGS ""

ENV CMAKE "cmake"
ENV MAKE "make"

RUN mkdir build
ENTRYPOINT ["/usr/bin/bash"]
#CMD ["./docker-build.sh"]