#!/bin/bash

#docker build --force-rm=true -f ./Dockerfile.gcc --build-arg gcc_version=11 -t abeimler/simple-cppbuilder:gcc-11 .
docker build --force-rm=true -f ./Dockerfile.gcc --build-arg gcc_version=10 -t abeimler/simple-cppbuilder:gcc-10 .
docker build --force-rm=true -f ./Dockerfile.gcc --build-arg gcc_version=9 -t abeimler/simple-cppbuilder:gcc-9 .
#docker build --force-rm=true -f ./Dockerfile.gcc --build-arg gcc_version=8 -t abeimler/simple-cppbuilder:gcc-8 .
#docker build --force-rm=true -f ./Dockerfile.gcc --build-arg gcc_version=7 -t abeimler/simple-cppbuilder:gcc-7 .
#docker build --force-rm=true -f ./Dockerfile.gcc --build-arg gcc_version=6 -t abeimler/simple-cppbuilder:gcc-6 .
#docker build --force-rm=true -f ./Dockerfile.gcc --build-arg gcc_version=5 -t abeimler/simple-cppbuilder:gcc-5 .
#docker build --force-rm=true -f ./Dockerfile.gcc --build-arg gcc_version=49 -t abeimler/simple-cppbuilder:gcc-4.9 .