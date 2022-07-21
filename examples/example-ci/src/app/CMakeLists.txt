add_executable(example-app)
target_sources(example-app PRIVATE main.cpp)
target_include_directories(example-app PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(example-app PRIVATE project_warnings project_options)
target_link_libraries(example-app PRIVATE example)

if (EMSCRIPTEN)
  set_target_properties(example-app PROPERTIES LINK_FLAGS "-s DEMANGLE_SUPPORT=1 -s WASM=0 -s USE_PTHREADS=1" )
endif()