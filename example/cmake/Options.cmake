##
# all kinds of options
##

## build options

## setup spdlog
option(USE_SPDLOG_LOGGING "Use spdlog for Logging" ON)
option(USE_PRINT_LOGGING "Use std::format for Logging" OFF)
if(CMAKE_BUILD_TYPE MATCHES Debug OR CMAKE_BUILD_TYPE MATCHES RelWithDebInfo)
  option(ENABLE_LOGGING "Enable Logging for ${CMAKE_PROJECT_NAME}" ON)
  set(SPDLOG_LEVEL_DEBUG 1)
  set(SPDLOG_LEVEL_INFO 0)
elseif(CMAKE_BUILD_TYPE MATCHES Release OR CMAKE_BUILD_TYPE MATCHES MinSizeRel)
  option(ENABLE_LOGGING "Enable Logging for ${CMAKE_PROJECT_NAME}" OFF)
  set(SPDLOG_LEVEL_DEBUG 0)
  set(SPDLOG_LEVEL_INFO 1)
endif()