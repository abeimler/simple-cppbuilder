## base image
FROM abeimler/simple-cppbuilder as base

## build stage
FROM base as build
COPY . .
## do more prepare for build stuff here
CMD ["./docker-build.sh"]

## test stage
FROM build as test
CMD ["./docker-test.sh"]