#!/bin/bash

docker build --force-rm=true -f ./Dockerfile.base -t abeimler/simple-cppbuilder:base .

docker build --force-rm=true -f ./Dockerfile.without-vcpkg -t abeimler/simple-cppbuilder:without-vcpkg .
docker build --force-rm=true -t abeimler/simple-cppbuilder .

docker build --force-rm=true -f ./Dockerfile.gcc --build-arg gcc_version=49 -t abeimler/simple-cppbuilder:gcc-4.9 .
docker build --force-rm=true -f ./Dockerfile.gcc --build-arg gcc_version=5 -t abeimler/simple-cppbuilder:gcc-5 .
docker build --force-rm=true -f ./Dockerfile.gcc --build-arg gcc_version=6 -t abeimler/simple-cppbuilder:gcc-6 .
docker build --force-rm=true -f ./Dockerfile.gcc --build-arg gcc_version=7 -t abeimler/simple-cppbuilder:gcc-7 .
docker build --force-rm=true -f ./Dockerfile.gcc --build-arg gcc_version=8 -t abeimler/simple-cppbuilder:gcc-8 .
docker build --force-rm=true -f ./Dockerfile.gcc --build-arg gcc_version=9 -t abeimler/simple-cppbuilder:gcc-9 .
docker build --force-rm=true -f ./Dockerfile.gcc --build-arg gcc_version=10 -t abeimler/simple-cppbuilder:gcc-10 .
docker build --force-rm=true -f ./Dockerfile.clang -t abeimler/simple-cppbuilder:clang .

docker build --force-rm=true --build-arg extra_libraries="mesa glu glfw libx11 libxrender libxext libxcursor libxrandr libxinerama xorg-server-devel" -t abeimler/simple-cppbuilder:opengl-libs .
docker build --force-rm=true --build-arg extra_libraries="boost" -t abeimler/simple-cppbuilder:boost .
docker build --force-rm=true -f ./Dockerfile.clang --build-arg extra_libraries="libc++" -t abeimler/simple-cppbuilder:libcpp .


docker build --force-rm=true -f ./Dockerfile.mingw-w64 --build-arg vcpkg_target_triplet=x64-mingw-dynamic --build-arg cross_triplet=x86_64-w64-mingw32 --build-arg processor=x86_64 -t abeimler/simple-cppbuilder:x64-mingw-w64 .
docker build --force-rm=true -f ./Dockerfile.mingw-w64 --build-arg vcpkg_target_triplet=x86-mingw-dynamic --build-arg cross_triplet=i686-w64-mingw32 --build-arg processor=i686 -t abeimler/simple-cppbuilder:x86-mingw-w64 .
docker build --force-rm=true -f ./Dockerfile.mingw-w64 --build-arg vcpkg_target_triplet=arm64-mingw-dynamic --build-arg cross_triplet=arm64-w64-mingw32 --build-arg processor=arm64 -t abeimler/simple-cppbuilder:arm64-mingw-w64 .
docker build --force-rm=true -f ./Dockerfile.mingw-w64 --build-arg vcpkg_target_triplet=arm-mingw-dynamic --build-arg cross_triplet=arm-w64-mingw32 --build-arg processor=arm -t abeimler/simple-cppbuilder:arm-mingw-w64 .


#docker build --force-rm=true -f ./Dockerfile.mingw-w64.mxe --build-arg vcpkg_target_triplet=x64-mingw-dynamic --build-arg cross_triplet=x86_64-w64-mingw32.shared --build-arg processor=x86_64 -t abeimler/simple-cppbuilder:x64-mingw-w64-shared-mxe .
#docker build --force-rm=true -f ./Dockerfile.mingw-w64.mxe --build-arg vcpkg_target_triplet=x86-mingw-dynamic --build-arg cross_triplet=i686-w64-mingw32.shared --build-arg processor=i686 -t abeimler/simple-cppbuilder:x86-mingw-w64-shared-mxe .
#docker build --force-rm=true -f ./Dockerfile.mingw-w64.mxe --build-arg vcpkg_target_triplet=x64-mingw-static --build-arg cross_triplet=x86_64-w64-mingw32.static --build-arg processor=x86_64 -t abeimler/simple-cppbuilder:x64-mingw-w64-static-mxe .
#docker build --force-rm=true -f ./Dockerfile.mingw-w64.mxe --build-arg vcpkg_target_triplet=x86-mingw-static --build-arg cross_triplet=i686-w64-mingw32.static --build-arg processor=i686 -t abeimler/simple-cppbuilder:x86-mingw-w64-static-mxe .


docker build --force-rm=true -f ./Dockerfile.android --build-arg vcpkg_target_triplet=arm-android --build-arg android_abi=armeabi-v7a -t abeimler/simple-cppbuilder:arm-android .
docker build --force-rm=true -f ./Dockerfile.android --build-arg vcpkg_target_triplet=arm64-android --build-arg android_abi=arm64-v8a -t abeimler/simple-cppbuilder:arm64-android .
docker build --force-rm=true -f ./Dockerfile.android --build-arg vcpkg_target_triplet=x86-android --build-arg android_abi=x86 -t abeimler/simple-cppbuilder:x86-android .
docker build --force-rm=true -f ./Dockerfile.android --build-arg vcpkg_target_triplet=x64-android --build-arg android_abi=x86_64 -t abeimler/simple-cppbuilder:x64-android .


docker build --force-rm=true -f ./Dockerfile.emscripten -t abeimler/simple-cppbuilder:emscripten .


# this may take a while
#docker build --force-rm=true -f ./Dockerfile.gnueabihf -t abeimler/simple-cppbuilder:gnueabihf .
#docker build --force-rm=true -f ./Dockerfile.rpi --build-arg compiler_target="armv8-rpi2-linux-gnueabihf" -t abeimler/simple-cppbuilder:rpi2 .
#docker build --force-rm=true -f ./Dockerfile.rpi --build-arg compiler_target="armv8-rpi3-linux-gnueabihf" -t abeimler/simple-cppbuilder:rpi3 .
#docker build --force-rm=true -f ./Dockerfile.rpi --build-arg compiler_target="armv8-rpi4-linux-gnueabihf" -t abeimler/simple-cppbuilder:rpi4 .