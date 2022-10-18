#!/bin/bash

docker build --force-rm=true -f ./Dockerfile.base -t abeimler/simple-cppbuilder:base .

docker build --force-rm=true -t abeimler/simple-cppbuilder .
#docker build --force-rm=true -t abeimler/simple-cppbuilder:1.5.0 .

docker build --force-rm=true -f ./Dockerfile.without-vcpkg -t abeimler/simple-cppbuilder:without-vcpkg .

docker build --force-rm=true -f ./Dockerfile.clang -t abeimler/simple-cppbuilder:clang .

docker build --force-rm=true --build-arg extra_libraries="mesa glu glfw-x11 libx11 libxrender libxext libxcursor libxrandr libxinerama xorg-server-devel" -t abeimler/simple-cppbuilder:opengl-libs .
docker build --force-rm=true --build-arg extra_libraries="boost" -t abeimler/simple-cppbuilder:boost .
docker build --force-rm=true --build-arg extra_libraries="abseil-cpp" -t abeimler/simple-cppbuilder:abseil-cpp .
docker build --force-rm=true -f ./Dockerfile.clang --build-arg extra_libraries="libc++" -t abeimler/simple-cppbuilder:libcpp .

docker build --force-rm=true -f ./Dockerfile.ci -t abeimler/simple-cppbuilder:ci .
docker build --force-rm=true -f ./Dockerfile.ci-setup-cpp -t abeimler/simple-cppbuilder:ci-setup-cpp .
docker build --force-rm=true -f ./Dockerfile.ci-windows -t abeimler/simple-cppbuilder:ci-x64-mingw-w64 .