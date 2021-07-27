cmake_minimum_required(VERSION 3.15)

set(CMAKE_CXX_STANDARD 11)

add_executable(${CMAKE_PROJECT_NAME}-app)
target_sources(${CMAKE_PROJECT_NAME}-app PRIVATE main.cpp)
target_include_directories(${CMAKE_PROJECT_NAME}-app PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

set_target_properties(${CMAKE_PROJECT_NAME}-app PROPERTIES LINK_FLAGS "-s ASSERTIONS=1 -s WASM=1 -s ASYNCIFY -s USE_PTHREADS=1" )
