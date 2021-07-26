find_package(Catch2 CONFIG REQUIRED)
include(Catch)

add_library(test_main STATIC ${CMAKE_CURRENT_SOURCE_DIR}/test_main.cpp)
target_link_libraries(test_main PRIVATE project_options)
target_link_libraries(test_main PUBLIC Catch2::Catch2)

# supress warnings in the thirdparty libs
target_include_directories(test_main SYSTEM INTERFACE ${CATCH_INCLUDE_DIR})

add_subdirectory(tests)