## base image
FROM archlinux:base-devel AS base

ARG extra_libraries

RUN pacman -Syuu --noconfirm

# Install packages available from standard repos
RUN pacman-db-upgrade && \
    pacman -S --noconfirm --needed \
        gcc wget curl pkg-config zip unzip tar git go && \
    pacman -S --noconfirm  \
        clang binutils bison \
        ${extra_libraries} \
        python python-pip doxygen graphviz \
        cmake make ninja ccache cppcheck \
        valgrind gcovr perf gperftools \
        neovim emacs nano && \
    pacman -Scc --noconfirm

# install yay
RUN useradd -m -G nobody -s /bin/bash yay && passwd -d yay && echo "yay ALL=(ALL)  ALL" >> /etc/sudoers
RUN git clone --depth 1 https://aur.archlinux.org/yay.git /opt/yay 
WORKDIR /opt/yay
RUN chown -R yay:root . && chmod -R 775 .
USER yay
WORKDIR /opt/yay
RUN makepkg -si --noprogressbar --noconfirm
USER root
WORKDIR /

# install extra packages from AUR
USER yay
RUN yay -Syu --noconfirm && yay -S --noconfirm \
        extra-cmake-modules-git lcov cccc && \
    yay -Scc --noconfirm && \
    rm -rf /home/yay/.cache/*
USER root

# install task
ADD https://taskfile.dev/install.sh /tmp/taskfile_install.sh
RUN chmod +x /tmp/taskfile_install.sh
RUN /tmp/taskfile_install.sh -d -b /usr/local/bin && rm /tmp/taskfile_install.sh

# Install conan
RUN python -m pip install --no-cache-dir conan==1.56.0 && \
        conan --version
# Install more pip tools
RUN python -m pip install --no-cache-dir \
        cogapp==3.3.0 \
        coverage==7.0.3 \
        cmake-format==0.6.13 \
        cmakelint==1.4.2

# thx to https://github.com/lefticus/cpp_starter_project/pull/121

# By default, anything you run in Docker is done as superuser.
# Conan runs some install commands as superuser, and will prepend `sudo` to
# these commands, unless `CONAN_SYSREQUIRES_SUDO=0` is in your env variables.
ENV CONAN_SYSREQUIRES_SUDO 0
# Some packages request that Conan use the system package manager to install
# a few dependencies. This flag allows Conan to proceed with these installations;
# leaving this flag undefined can cause some installation failures.
ENV CONAN_SYSREQUIRES_MODE enabled


# set default compiler
#ENV CC "gcc"
#ENV CXX "g++"
#ENV CMAKE "cmake"
#ENV MAKE "make"

# setup project env
ENV PROJECT_DIR /home/project
WORKDIR /home/project


FROM base

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

# install vcpkg
ENV VCPKG_DISABLE_METRICS 1
RUN git clone --depth 1 https://github.com/Microsoft/vcpkg.git /home/project/vcpkg \
    && /home/project/vcpkg/bootstrap-vcpkg.sh -disableMetrics
ENV VCPKG_ROOT "/home/project/vcpkg"

ENV VCPKG_TOOLCHAIN_FILE "$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake"
ENV TOOLCHAIN_FILE "$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake"


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
COPY ./taskfiles/*.yml /home/taskfiles/
COPY ./taskfiles/TaskfileDefault.yml /home/taskfiles/Taskfile.yml

ENV PROJECT_DIR /home/project
WORKDIR /home/project
RUN mkdir build