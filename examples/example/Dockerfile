## base image
FROM abeimler/simple-cppbuilder as base

## add more system libs and dependencies here
#RUN pacman-db-upgrade && \
#    pacman -S --noconfirm  \
#        boost qt6-base qt6-tools

## build stage
FROM base as build
COPY . .
## do more prepare for build stuff here
CMD ["./docker-build.sh"]
## test stage
FROM build as test
CMD ["./docker-test.sh"]


# image using older gcc version
FROM abeimler/simple-cppbuilder:gcc9 as build-old-gcc
COPY . .
CMD ["./docker-build.sh"]
## test stage
FROM build as test-old-gcc
CMD ["./docker-test.sh"]


# image using clang
FROM abeimler/simple-cppbuilder:clang as build-clang
COPY . .
CMD ["./docker-build.sh"]
## test stage
FROM build as test-clang
CMD ["./docker-test.sh"]


## build for windows
FROM abeimler/simple-cppbuilder:x64-mingw-w64 as build-windows
COPY . .
CMD ["./docker-build.sh"]


## build for aarch64
FROM abeimler/simple-cppbuilder:aarch64-linux as build-arm64
COPY . .
CMD ["./docker-build.sh"]


## build for web
FROM abeimler/simple-cppbuilder:emscripten as build-web
COPY . .
CMD ["./docker-build.sh"]