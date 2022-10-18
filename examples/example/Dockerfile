# build stage
FROM abeimler/simple-cppbuilder as build
### update vcpkg
WORKDIR $VCPKG_ROOT
RUN git pull origin master
### copy project
WORKDIR $PROJECT_DIR
COPY . .
CMD ["./docker-build.sh"]

## test stage
FROM build as test
CMD ["./docker-test.sh"]

## test (coverage) stage
FROM test as test-coverage
COPY ./docker-test-coverage.sh ./docker-test-coverage.sh
CMD ["./docker-test-coverage.sh"]


# image using clang
FROM abeimler/simple-cppbuilder:clang as build-clang
### update vcpkg
WORKDIR $VCPKG_ROOT
RUN git pull origin master
### copy project
WORKDIR $PROJECT_DIR
COPY . .
CMD ["./docker-build.sh"]
## test stage
FROM build-clang as test-clang
CMD ["./docker-test.sh"]


## build for windows
FROM abeimler/simple-cppbuilder:x64-mingw-w64 as build-windows
### update vcpkg
WORKDIR $VCPKG_ROOT
RUN git pull origin master
### copy project
WORKDIR $PROJECT_DIR
COPY . .
CMD ["./docker-build.sh"]


## build for aarch64
FROM abeimler/simple-cppbuilder:aarch64-linux as build-arm64
### update vcpkg
WORKDIR $VCPKG_ROOT
RUN git pull origin master
### copy project
WORKDIR $PROJECT_DIR
COPY . .
CMD ["./docker-build.sh"]


## build for aarch64
FROM abeimler/simple-cppbuilder:rpi4 as build-rpi4
### update vcpkg
WORKDIR $VCPKG_ROOT
RUN git pull origin master
### copy project
WORKDIR $PROJECT_DIR
COPY . .
CMD ["./docker-build.sh"]


## build for web
FROM abeimler/simple-cppbuilder:emscripten as build-web
### update vcpkg
WORKDIR $VCPKG_ROOT
RUN git pull origin master
### copy project
WORKDIR $PROJECT_DIR
COPY . .
CMD ["./docker-build.sh"]