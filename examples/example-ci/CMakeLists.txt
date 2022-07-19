cmake_minimum_required(VERSION 3.16...3.23)
if(DEFINED ENV{VCPKG_ROOT} AND NOT DEFINED CMAKE_TOOLCHAIN_FILE)
  set(CMAKE_TOOLCHAIN_FILE "$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake"
      CACHE STRING "")
endif()

# Not ideal to use this global variable, but necessary to make sure
# that tooling and projects use the same version
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_C_STANDARD 99)

# strongly encouraged to enable this globally to avoid conflicts between
# -Wpedantic being enabled and -std=c++20 and -std=gnu++20 for example
# when compiling with PCH enabled
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_C_EXTENSIONS ON)

# Note: by default ENABLE_DEVELOPER_MODE is True
# This means that all analysis (sanitizers, static analysis) is enabled
# if you want to switch this behavior, change TRUE to FALSE
set(ENABLE_DEVELOPER_MODE
        FALSE
        CACHE BOOL "Enable 'developer mode'")


# Any default can be overridden
# set(<feature_name>_DEFAULT <value>) - set default for both user and developer modes
# set(<feature_name>_DEVELOPER_DEFAULT <value>) - set default for developer mode
# set(<feature_name>_USER_DEFAULT <value>) - set default for user mode
set(OPT_ENABLE_CONAN OFF)
set(OPT_WARNINGS_AS_ERRORS OFF)

include(FetchContent)
# Add project_options
# https://github.com/cpp-best-practices/project_options
FetchContent_Declare(_project_options URL https://github.com/cpp-best-practices/project_options/archive/refs/tags/v0.24.0.zip)
FetchContent_MakeAvailable(_project_options)
include(${_project_options_SOURCE_DIR}/Index.cmake)

# Set the project name to your project name, my project isn't very descriptive
project(example VERSION 0.1.0 LANGUAGES C CXX)
if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(
    FATAL_ERROR
      "In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there."
  )
endif()


get_property(BUILDING_MULTI_CONFIG GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
if(BUILDING_MULTI_CONFIG)
  if(NOT CMAKE_BUILD_TYPE)
    # Make sure that all supported configuration types have their
    # associated conan packages available. You can reduce this
    # list to only the configuration types you use, but only if one
    # is not forced-set on the command line for VS
    message(TRACE "Setting up multi-config build types")
    set(CMAKE_CONFIGURATION_TYPES
            Debug
            Release
            RelWithDebInfo
            MinSizeRel
            CACHE STRING "Enabled build types" FORCE)
  else()
    message(TRACE "User chose a specific build type, so we are using that")
    set(CMAKE_CONFIGURATION_TYPES
            ${CMAKE_BUILD_TYPE}
            CACHE STRING "Enabled build types" FORCE)
  endif()
endif()

include(${_project_options_SOURCE_DIR}/src/DynamicProjectOptions.cmake)

set(ENABLE_CLANG_TIDY OFF)
set(ENABLE_CPPCHECK OFF)
set(ENABLE_SANITIZER_ADDRESS OFF)
set(ENABLE_SANITIZER_UNDEFINED_BEHAVIOR OFF)

option(ENABLE_CHECKING "Enable Static analyzer" OFF)
if(ENABLE_CHECKING)
  set(ENABLE_CLANG_TIDY "ENABLE_CLANG_TIDY")
  set(ENABLE_CPPCHECK "ENABLE_CPPCHECK")
endif()

option(ENABLE_TESTING "Enable the tests" ${PROJECT_IS_TOP_LEVEL})
if(ENABLE_TESTING)
  if(NOT "${CMAKE_SYSTEM_NAME}" STREQUAL "Windows")
    set(ENABLE_SANITIZER_ADDRESS "ENABLE_SANITIZER_ADDRESS")
    set(ENABLE_SANITIZER_UNDEFINED_BEHAVIOR "ENABLE_SANITIZER_UNDEFINED_BEHAVIOR")
  else()
  # FIXME: Catch2d.lib(catch_istream.cpp.obj) : error LNK2038: mismatch detected for 'annotate_vector': value '0' doesn't match value '1'
  #  # or it is MSVC and has run vcvarsall
  #  string(FIND "$ENV{PATH}" "$ENV{VSINSTALLDIR}" index_of_vs_install_dir)
  #  if(MSVC AND "${index_of_vs_install_dir}" STREQUAL "-1")
  #    set(ENABLE_SANITIZER_ADDRESS "ENABLE_SANITIZER_ADDRESS")
  #  endif()
  endif()
endif()

# defaulted_project_options sets recommended defaults and provides user and developer
# modes and full GUI support for choosing options at configure time
# for more flexibility, look into project_options() macro
# Initialize project_options variable related to this project
# This overwrites `project_options` and sets `project_warnings`
# uncomment the options to enable them:
dynamic_project_options(
  ENABLE_CACHE
  ${ENABLE_CPPCHECK}
  ${ENABLE_CLANG_TIDY}
  ENABLE_VS_ANALYSIS
  ${ENABLE_SANITIZER_ADDRESS}
  ${ENABLE_SANITIZER_UNDEFINED_BEHAVIOR}
  # Note: PCH is disabled by default in developer mode because these headers become
  # globally included and they can mask other errors
  PCH_HEADERS
  # This is a list of headers to pre-compile, here are some common ones
  <vector>
  <string>
  <unordered_map>
  <utility>
  <array>
  <algorithm>
  <concepts>
  CPPCHECK_OPTIONS
  --enable=style,performance,warning,portability
  --inline-suppr
  # We cannot act on a bug/missing feature of cppcheck
  --suppress=cppcheckError
  --suppress=internalAstError
  # if a file does not have an internalAstError, we get an unmatchedSuppression error
  --suppress=unmatchedSuppression
  --suppress=passedByValue
  --suppress=syntaxError
  --suppress=*:${CMAKE_BINARY_DIR}/_deps/*
  --suppress=*:${CMAKE_SOURCE_DIR}/libs/*
  --inconclusive
)
target_compile_features(project_options INTERFACE cxx_std_${CMAKE_CXX_STANDARD})

# ---- Add dependencies via CPM ----
# see https://github.com/TheLartians/CPM.cmake for more info
include(cmake/CPM.cmake)

# PackageProject.cmake will be used to make our target installable
CPMAddPackage("gh:TheLartians/PackageProject.cmake@1.9.0")
CPMAddPackage("gh:TheLartians/Format.cmake@1.7.3")

option(ENABLE_TESTING "Enable Test Builds" ON)
if(ENABLE_TESTING)
  # This variable is set by project() in CMake 3.21+
  string(COMPARE EQUAL
          "${CMAKE_SOURCE_DIR}"
          "${PROJECT_SOURCE_DIR}"
          PROJECT_IS_TOP_LEVEL)
  if(PROJECT_IS_TOP_LEVEL)
    # Consider the CTest module, which creates targets and options!
    # Only needed if you want to enable submissions to a CDash server.
    include(CTest)
  endif()
  enable_testing()
  message(AUTHOR_WARNING "Building Tests. Be sure to check out test/")
  add_subdirectory(test)
endif()

add_subdirectory(src)

# If MSVC is being used, and ASAN is enabled, we need to set the debugger environment
# so that it behaves well with MSVC's debugger, and we can run the target from visual studio
if(MSVC)
  get_all_targets(all_targets)
  set_target_properties(${all_targets} PROPERTIES VS_DEBUGGER_ENVIRONMENT "PATH=$(VC_ExecutablePath_x64);%PATH%")
endif()
