cmake_minimum_required(VERSION 3.16)
project(QtHelloWorld)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find Qt6 components
find_package(Qt6 REQUIRED COMPONENTS Core Widgets)

# Enable Qt's MOC (Meta-Object Compiler)
set(CMAKE_AUTOMOC ON)

# Add executable
add_executable(QtHelloWorld
    src/main.cpp
    src/mainwindow.cpp
    src/mainwindow.h
)

# Link Qt libraries
target_link_libraries(QtHelloWorld Qt6::Core Qt6::Widgets)
