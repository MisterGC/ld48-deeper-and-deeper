cmake_minimum_required (VERSION 3.5.0 FATAL_ERROR)
project (Astromoles VERSION 2021.1)

# Common dirs for all produced bin artifacts 
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt5 5.15 COMPONENTS Core Quick Multimedia Sql REQUIRED)
qt5_add_big_resources(GAME_ASSETS src/scene/scene.qrc src/sound/sound.qrc src/visual/visual.qrc)
set(PROJECT_SOURCES src/main.cpp src/Sandbox.qml src/qml/qml.qrc ${GAME_ASSETS})

add_executable(${PROJECT_NAME} ${PROJECT_SOURCES})
target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_17)

target_link_libraries(${PROJECT_NAME}
PRIVATE
  Qt5::Core
  Qt5::Quick
)

add_subdirectory (dep/clayground)
