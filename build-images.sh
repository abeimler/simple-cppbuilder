#!/bin/bash

docker build --force-rm=true -f ./Dockerfile.base -t abeimler/simple-cppbuilder:base .

docker build --force-rm=true -t abeimler/simple-cppbuilder .

docker build --force-rm=true -f ./Dockerfile.without-vcpkg -t abeimler/simple-cppbuilder:without-vcpkg .

docker build --force-rm=true -f ./Dockerfile.clang -t abeimler/simple-cppbuilder:clang .

docker build --force-rm=true --build-arg extra_libraries="mesa glu glfw libx11 libxrender libxext libxcursor libxrandr libxinerama xorg-server-devel" -t abeimler/simple-cppbuilder:opengl-libs .
docker build --force-rm=true --build-arg extra_libraries="boost" -t abeimler/simple-cppbuilder:boost .
docker build --force-rm=true --build-arg extra_libraries="abseil-cpp" -t abeimler/simple-cppbuilder:abseil-cpp .
docker build --force-rm=true -f ./Dockerfile.clang --build-arg extra_libraries="libc++" -t abeimler/simple-cppbuilder:libcpp .

docker build --force-rm=true -f ./Dockerfile.emscripten -t abeimler/simple-cppbuilder:emscripten .
