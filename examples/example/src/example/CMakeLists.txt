add_library(${CMAKE_PROJECT_NAME} STATIC)
target_sources(${CMAKE_PROJECT_NAME} PRIVATE example.h example.cpp)
target_include_directories(${CMAKE_PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE project_warnings project_options)

# unity
if(ENABLE_UNITY)
  # Add for any project you want to apply unity builds for
  set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES UNITY_BUILD ON)
endif()