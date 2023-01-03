## base image
FROM abeimler/simple-cppbuilder:ci-setup-cpp as base
COPY . .

## build stage
FROM base as build
COPY . .
CMD ["task", "-t", "/home/taskfiles/Taskfile.yml", "build"]
## test stage
FROM build as test
CMD ["task", "-t", "/home/taskfiles/Taskfile.yml", "test"]


## build for windows
FROM abeimler/simple-cppbuilder:ci-x64-mingw-w64 as build-windows
COPY . .
CMD ["task", "-t", "/home/taskfiles/Taskfile.yml", "build"]