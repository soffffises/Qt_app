cmake_minimum_required(VERSION 3.16)

project(TemperatureApp VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS
    Quick
    QuickControls2
)

qt_standard_project_setup()

add_executable(TemperatureApp
    main.cpp
    Main.qml
    TemperatureModel.cpp
    TemperatureModel.h
    TemperatureController.cpp
    TemperatureController.h
)

target_link_libraries(TemperatureApp
    PRIVATE Qt6::Quick
    PRIVATE Qt6::QuickControls2
)
