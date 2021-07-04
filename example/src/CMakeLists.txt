add_library(${CMAKE_PROJECT_NAME} STATIC)
target_sources(${CMAKE_PROJECT_NAME} PRIVATE example.h example.cpp)
target_include_directories(${CMAKE_PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE project_warnings project_options)

# add libs here
find_package(magic_enum CONFIG REQUIRED)
find_package(Microsoft.GSL CONFIG REQUIRED)
target_link_libraries(
  ${CMAKE_PROJECT_NAME} PUBLIC
  Microsoft.GSL::GSL
  magic_enum::magic_enum)

# unity
if(ENABLE_UNITY)
  # Add for any project you want to apply unity builds for
  set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES UNITY_BUILD ON)
endif()