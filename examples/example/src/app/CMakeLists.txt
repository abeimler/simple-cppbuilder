add_executable(${CMAKE_PROJECT_NAME}-app)
target_sources(${CMAKE_PROJECT_NAME}-app PRIVATE main.cpp)
target_include_directories(${CMAKE_PROJECT_NAME}-app PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(${CMAKE_PROJECT_NAME}-app PRIVATE project_warnings project_options)
target_link_libraries(${CMAKE_PROJECT_NAME}-app PRIVATE example)

# unity
if(ENABLE_UNITY)
  # Add for any project you want to apply unity builds for
  set_target_properties(${CMAKE_PROJECT_NAME}-app PROPERTIES UNITY_BUILD ON)
endif()