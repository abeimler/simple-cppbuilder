## base image
FROM abeimler/simple-cppbuilder:emscripten as base

## build stage
FROM base as build
COPY . .
CMD ["task", "-t", "/home/taskfiles/Taskfile.yml", "build"]