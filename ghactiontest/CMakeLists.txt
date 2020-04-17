cmake_minimum_required (VERSION 3.5.0 FATAL_ERROR)
project (ghactiontest)
set (CMAKE_INCLUDE_CURRENT_DIR on)

set (EXE_SOURCES main.cpp)
add_executable (${PROJECT_NAME} ${EXE_SOURCES})

set_target_properties (${PROJECT_NAME} PROPERTIES
    CXX_STANDARD 11
    CXX_STANDARD_REQUIRED ON
    CXX_EXTENSIONS NO
    )
