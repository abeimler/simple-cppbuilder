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