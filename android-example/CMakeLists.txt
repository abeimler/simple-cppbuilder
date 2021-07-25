cmake_minimum_required(VERSION 3.0)

if (VCPKG_TARGET_ANDROID)
    include("cmake/vcpkg_android.cmake")
endif()

project(android-example)

find_package(jsoncpp CONFIG REQUIRED)
add_library(my_lib my_lib.cpp)
target_link_libraries(my_lib jsoncpp_lib)