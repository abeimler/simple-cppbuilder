## base image
FROM abeimler/simple-cppbuilder:arm-android as base

# Install the library via vcpkg
RUN ./vcpkg/vcpkg install jsoncpp:$TARGET_TRIPLET

## build stage
FROM base as build
COPY . .
CMD ["task", "-t", "/home/taskfiles/Taskfile.yml", "build"]