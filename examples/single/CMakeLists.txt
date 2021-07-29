cmake_minimum_required(VERSION 3.15)

# Set the project name to your project name, my project isn't very descriptive
project(myapp VERSION 0.1.0 LANGUAGES C CXX)

add_executable(myapp)
target_sources(myapp PRIVATE main.cpp)
target_include_directories(myapp PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})