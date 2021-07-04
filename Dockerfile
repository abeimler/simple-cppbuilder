## base image
FROM archlinux:base-devel as base

# default compiler versions
ARG gcc_version=10
ARG extra_libraries

# Install packages available from standard repos
RUN pacman-db-upgrade && \
    pacman -Syyu --noconfirm && pacman-db-upgrade && \
    pacman -S --noconfirm --needed \
        wget curl pkg-config zip unzip tar git go && \
    pacman -S --noconfirm  \
        gcc${gcc_version} clang binutils bison \
        ${extra_libraries} \
        python3 python-pip doxygen graphviz cmake make ninja ccache cppcheck valgrind gcovr \
        neovim emacs nano

# install yay
RUN useradd -m -G nobody -s /bin/bash yay && passwd -d yay && echo "yay ALL=(ALL)  ALL" >> /etc/sudoers
RUN git clone https://aur.archlinux.org/yay.git /opt/yay && cd /opt/yay && \
    chown -R yay:root . && chmod -R 775 . && \
    runuser -l yay -c "cd /opt/yay && makepkg -si --noprogressbar --noconfirm"
RUN cd /

# install extra packages from AUR
RUN runuser -l yay -c \
    "yay -Syu --noconfirm && yay -S --noconfirm \
        extra-cmake-modules-git lcov cccc" && \
    rm -rf /home/yay/.cache/*

# Install conan
RUN python3 -m pip install --upgrade pip setuptools && \
    python3 -m pip install conan && \
    conan --version
# Install more pip tools
RUN python3 -m pip install --upgrade pip setuptools && \
    python3 -m pip install cogapp

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
RUN git clone https://github.com/Microsoft/vcpkg.git
RUN ./vcpkg/bootstrap-vcpkg.sh
RUN mkdir build
ENTRYPOINT ["/usr/bin/bash"]
CMD ["./docker-build.sh"]