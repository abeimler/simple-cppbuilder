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


## base image for windows
FROM abeimler/simple-cppbuilder:x64-mingw-w64 as base-windows

## build stage
FROM base-windows as windows-build
COPY . .
CMD ["./docker-build.sh"]


## base image for windows
FROM abeimler/simple-cppbuilder:x64-mingw-w64-mxe as base-windows-mxe

## build stage
FROM base-windows-mxe as windows-build-mxe
COPY . .
CMD ["./docker-build.sh"]

## base image for web
FROM abeimler/simple-cppbuilder:emscripten as base-web

## build stage
FROM base-web as build-web
COPY . .
CMD ["./docker-build.sh"]