## base image
FROM abeimler/simple-cppbuilder:ci-setup-cpp as base
COPY . .

## build stage
FROM base as build
COPY . .
CMD ["./docker-build.sh"]
## test stage
FROM build as test
CMD ["./docker-test.sh"]


## build for windows
FROM abeimler/simple-cppbuilder:ci-x64-mingw-w64 as build-windows
COPY . .
CMD ["./docker-build.sh"]