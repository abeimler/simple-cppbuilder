add_executable(example-test)
target_sources(example-test PRIVATE test.cpp)
target_include_directories(example-test PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(example-test PRIVATE project_warnings project_options)

# add libs here
target_link_libraries(example-test PRIVATE example)
target_link_system_libraries(example-test PRIVATE Catch2::Catch2 Catch2::Catch2WithMain)

# automatically discover tests that are defined in catch based test files you can modify the unittests. Set TEST_PREFIX to whatever you
# want, or use different for different binaries
catch_discover_tests(example-test)

# FIX: https://docs.microsoft.com/en-us/cpp/sanitizers/error-container-overflow?view=msvc-170 
#if(MSVC)
# target_compile_definitions(${CMAKE_PROJECT_NAME}-core-tests PRIVATE -D_DISABLE_VECTOR_ANNOTATION) 
#endif()
