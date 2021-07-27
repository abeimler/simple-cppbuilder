cmake_minimum_required(VERSION 3.15)

set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR $ENV{PROCESSOR})

#set(CMAKE_SYSROOT $ENV{CROSS_ROOT})
set(CMAKE_FIND_ROOT_PATH $ENV{CROSS_ROOT})
set(CMAKE_STAGING_PREFIX /home/stage)

set(CMAKE_C_COMPILER $ENV{CROSS_TRIPLET}-gcc)
set(CMAKE_CXX_COMPILER $ENV{CROSS_TRIPLET}-g++)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)