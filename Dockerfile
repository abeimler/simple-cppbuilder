## base image
FROM abeimler/simple-cppbuilder:base as base

# default compiler versions
ARG gcc_version=10
ARG extra_libraries

# Install packages available from standard repos
RUN pacman-db-upgrade && \
    pacman -Syyu --noconfirm && pacman-db-upgrade && \
    pacman -S --noconfirm --needed \
        wget curl pkg-config zip unzip tar git go && \
    pacman -S --noconfirm  \
        gcc${gcc_version} binutils bison \
        ${extra_libraries} \
        python3 python-pip doxygen graphviz cmake make ninja ccache cppcheck valgrind gcovr \
        neovim emacs nano

# set default compiler
ENV CC "gcc"
ENV CXX "g++"

# setup project env
WORKDIR /home/project
ENV TARGET "all"
ENV BUILD_TYPE "Release"
ENV CMAKE_GENERATOR "Ninja"
ENV TOOLCHAIN_FILE "./vcpkg/scripts/buildsystems/vcpkg.cmake"
ENV CMAKE_ARGS ""
COPY ./docker-build.sh ./docker-build.sh
COPY ./docker-test.sh ./docker-test.sh

ENV VCPKG_DISABLE_METRICS 1
RUN git clone https://github.com/Microsoft/vcpkg.git
RUN ./vcpkg/bootstrap-vcpkg.sh -disableMetrics
RUN mkdir build

ENTRYPOINT ["/usr/bin/bash"]
CMD ["./docker-build.sh"]