## base image
FROM abeimler/simple-cppbuilder:base AS base
ENV CONAN_SYSREQUIRES_SUDO 0
ENV CONAN_SYSREQUIRES_MODE enabled
ENV CMAKE_GENERATOR Ninja
COPY . .

## base image with OpenGL dependencies
FROM abeimler/simple-cppbuilder:base AS base-opengl-libs
RUN runuser -l yay -c "yay -Syu --noconfirm && yay -S --noconfirm mesa glu glfw-x11 libx11"
ENV CONAN_SYSREQUIRES_SUDO 0
ENV CONAN_SYSREQUIRES_MODE enabled
ENV CMAKE_GENERATOR Ninja
COPY . .

FROM base AS gcc
# gcc already installed
ENV CC gcc
ENV CXX g++

FROM base AS clang
RUN pacman-db-upgrade && pacman -S --noconfirm clang
ENV CC clang
ENV CXX clang++


## build stage
FROM gcc AS build
COPY . .
CMD ["task", "-t", "/home/taskfiles/Taskfile.yml", "build"]

## test stage
FROM build AS test
CMD ["task", "-t", "/home/taskfiles/Taskfile.yml", "test"]



## add more targets for different libraries
FROM base-opengl-libs AS fltk
# install fltk
RUN runuser -l yay -c "yay -Syu --noconfirm && yay -S --noconfirm fltk fluid"
# set CMake Args
ENV CMAKE_ARGS -DCPP_STARTER_USE_FLTK=ON
COPY . .
CMD ["task", "-t", "/home/taskfiles/Taskfile.yml", "build"]


FROM base AS gtkmm
# install gtkmm
RUN runuser -l yay -c "yay -Syu --noconfirm && yay -S --noconfirm gtkmm"
# set CMake Args
ENV CMAKE_ARGS -DCPP_STARTER_USE_GTKMM=ON
COPY . .
CMD ["task", "-t", "/home/taskfiles/Taskfile.yml", "build"]


FROM base-opengl-libs AS imgui
# set CMake Args
ENV CMAKE_ARGS -DCPP_STARTER_USE_IMGUI=ON
COPY . .
CMD ["task", "-t", "/home/taskfiles/Taskfile.yml", "build"]


FROM base AS qt5
# install qt
RUN runuser -l yay -c "yay -Syu --noconfirm && yay -S --noconfirm qt5-base"
# set CMake Args
ENV CMAKE_ARGS -DCPP_STARTER_USE_QT=ON
COPY . .
CMD ["task", "-t", "/home/taskfiles/Taskfile.yml", "build"]


FROM base AS sdl
# install sdl2
RUN runuser -l yay -c "yay -Syu --noconfirm && yay -S --noconfirm sdl2"
# set CMake Args
ENV CMAKE_ARGS -DCPP_STARTER_USE_SDL=ON
COPY . .
CMD ["task", "-t", "/home/taskfiles/Taskfile.yml", "build"]


FROM base-opengl-libs AS nana
# install dependencies
RUN runuser -l yay -c "yay -Syu --noconfirm && yay -S --noconfirm nana alsa-lib alsa-utils alsa-oss libxcursor"
# set CMake Args
ENV CMAKE_ARGS -DCPP_STARTER_USE_NANA=ON -DWARNINGS_AS_ERRORS=FALSE
COPY . .
CMD ["task", "-t", "/home/taskfiles/Taskfile.yml", "build"]