#!/bin/bash

docker build --force-rm=true -f ./Dockerfile.base -t abeimler/simple-cppbuilder:base .

docker build --force-rm=true -t abeimler/simple-cppbuilder .
docker build --force-rm=true -f ./Dockerfile.without-vcpkg -t abeimler/simple-cppbuilder:without-vcpkg .

docker build --force-rm=true --build-arg gcc_version=10 -t abeimler/simple-cppbuilder:gcc10 .
docker build --force-rm=true -f ./Dockerfile.clang -t abeimler/simple-cppbuilder:clang .

docker build --force-rm=true -f ./Dockerfile.mingw-w64 --build-arg triplet=x64-mingw-dynamic --build-arg target=x86_64-w64-mingw32 --build-arg processor=x86_64 --build-arg cc=x86_64-w64-mingw32-gcc --build-arg cxx=x86_64-w64-mingw32-g++ -t abeimler/simple-cppbuilder:x64-mingw-w64 .
docker build --force-rm=true -f ./Dockerfile.mingw-w64 --build-arg triplet=x86-mingw-dynamic --build-arg target=i686-w64-mingw32 --build-arg processor=i686 --build-arg cc=i686-w64-mingw32-gcc --build-arg cxx=i686-w64-mingw32-g++ -t abeimler/simple-cppbuilder:x86-mingw-w64 .
docker build --force-rm=true -f ./Dockerfile.mingw-w64 --build-arg triplet=arm64-mingw-dynamic --build-arg target=arm64-w64-mingw32 --build-arg processor=arm64 --build-arg cc=arm64-w64-mingw32-gcc --build-arg cxx=arm64-w64-mingw32-g++ -t abeimler/simple-cppbuilder:arm64-mingw-w64 .
docker build --force-rm=true -f ./Dockerfile.mingw-w64 --build-arg triplet=arm-mingw-dynamic --build-arg target=arm-w64-mingw32 --build-arg processor=arm --build-arg cc=arm-w64-mingw32-gcc --build-arg cxx=arm-w64-mingw32-g++ -t abeimler/simple-cppbuilder:arm64-mingw-w64 .

#docker build --force-rm=true -f ./Dockerfile.android --build-arg triplet=arm-android -t abeimler/simple-cppbuilder:arm-android .
#docker build --force-rm=true -f ./Dockerfile.android --build-arg triplet=arm64-android -t abeimler/simple-cppbuilder:arm64-android .
#docker build --force-rm=true -f ./Dockerfile.android --build-arg triplet=x86-android -t abeimler/simple-cppbuilder:x86-android .
#docker build --force-rm=true -f ./Dockerfile.android --build-arg triplet=x64-android -t abeimler/simple-cppbuilder:x64-android .

docker build --force-rm=true -f ./Dockerfile.gnueabihf -t abeimler/simple-cppbuilder:gnueabihf .

docker build --force-rm=true --build-arg extra_libraries="mesa glu glfw libx11 libxrender libxext libxcursor libxrandr libxinerama xorg-server-devel" -t abeimler/simple-cppbuilder:opengl-libs .
docker build --force-rm=true -f ./Dockerfile.clang --build-arg extra_libraries="libc++" -t abeimler/simple-cppbuilder:libcpp .
docker build --force-rm=true --build-arg extra_libraries="boost" -t abeimler/simple-cppbuilder:boost .


docker build --force-rm=true -f ./Dockerfile.rpi --build-arg cross_compiler="armv8-rpi2-linux-gnueabihf" -t abeimler/simple-cppbuilder:rpi2 .
docker build --force-rm=true -f ./Dockerfile.rpi --build-arg cross_compiler="armv8-rpi3-linux-gnueabihf" -t abeimler/simple-cppbuilder:rpi3 .
docker build --force-rm=true -f ./Dockerfile.rpi --build-arg cross_compiler="armv8-rpi4-linux-gnueabihf" -t abeimler/simple-cppbuilder:rpi4 .