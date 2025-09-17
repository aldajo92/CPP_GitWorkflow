cmake_minimum_required(VERSION 3.16)
project(QtHelloWorld VERSION 1.0.0)

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

# Install targets
install(TARGETS QtHelloWorld
    RUNTIME DESTINATION bin
)

# Create desktop entry file
configure_file(
    ${CMAKE_SOURCE_DIR}/qt-hello-world.desktop.in
    ${CMAKE_BINARY_DIR}/qt-hello-world.desktop
    @ONLY
)

# Install desktop entry
install(FILES ${CMAKE_BINARY_DIR}/qt-hello-world.desktop
    DESTINATION share/applications
)

# CPack configuration
set(CPACK_PACKAGE_NAME "qt-hello-world")
set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Qt Hello World Toggle Application")
set(CPACK_PACKAGE_DESCRIPTION "A simple Qt application with a button to toggle Hello World text visibility.")
set(CPACK_PACKAGE_CONTACT "Your Name <your.email@example.com>")
set(CPACK_PACKAGE_VENDOR "Your Company")

# DEB-specific settings
set(CPACK_DEBIAN_PACKAGE_DEPENDS "libqt6core6, libqt6gui6, libqt6widgets6")
set(CPACK_DEBIAN_PACKAGE_SECTION "utils")
set(CPACK_DEBIAN_PACKAGE_PRIORITY "optional")
set(CPACK_DEBIAN_PACKAGE_HOMEPAGE "https://github.com/yourname/qt-hello-world")

# Detect architecture
if(CMAKE_SYSTEM_PROCESSOR STREQUAL "aarch64" OR CMAKE_SYSTEM_PROCESSOR STREQUAL "arm64")
    set(PACKAGE_ARCH "arm64")
else()
    set(PACKAGE_ARCH "amd64")
endif()

# Set package file name with correct architecture
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}_${PROJECT_VERSION}_${PACKAGE_ARCH}")
set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE "${PACKAGE_ARCH}")

# Enable DEB generator
set(CPACK_GENERATOR "DEB")

# Include CPack
include(CPack)
