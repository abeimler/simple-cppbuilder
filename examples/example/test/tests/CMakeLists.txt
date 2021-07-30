add_executable(${CMAKE_PROJECT_NAME}-test)
target_sources(${CMAKE_PROJECT_NAME}-test PRIVATE test.cpp)
target_include_directories(${CMAKE_PROJECT_NAME}-test PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(${CMAKE_PROJECT_NAME}-test PRIVATE project_warnings project_options)
target_compile_definitions(${CMAKE_PROJECT_NAME}-test PRIVATE -DTESTING)

# add libs here
set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)
target_link_libraries(${CMAKE_PROJECT_NAME}-test PRIVATE test_main Threads::Threads)
target_link_libraries(${CMAKE_PROJECT_NAME}-test PRIVATE ${CMAKE_PROJECT_NAME})


# automatically discover tests that are defined in catch based test files you can modify the unittests. Set TEST_PREFIX
# to whatever you want, or use different for different binaries
catch_discover_tests(
  ${CMAKE_PROJECT_NAME}-test
  TEST_PREFIX
  "unittests."
  REPORTER
  xml
  OUTPUT_DIR
  .
  OUTPUT_PREFIX
  "unittests."
  OUTPUT_SUFFIX
  .xml)

if(ENABLE_COVERAGE)
  setup_target_for_coverage_gcovr_html(
    NAME
    ${CMAKE_PROJECT_NAME}-coverage-test
    EXECUTABLE
    ${CMAKE_PROJECT_NAME}-test
    EXCLUDE
    "${PROJECT_SOURCE_DIR}/test"
    "${PROJECT_SOURCE_DIR}/thirdparty"
    "${CMAKE_BINARY_DIR}/_deps")
endif()
