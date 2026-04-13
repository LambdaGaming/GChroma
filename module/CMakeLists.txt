cmake_minimum_required(VERSION 3.10)

project(gchroma-project LANGUAGES CXX)

set(CMAKE_CONFIGURATION_TYPES Release Debug)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_subdirectory(gmod-module-base/include)
add_subdirectory(OpenRGB-cppSDK)

add_library(gchroma SHARED)
target_sources(gchroma PRIVATE main.cpp)
target_link_libraries(gchroma gmod-module-base orgbsdk)

set_gmod_suffix_prefix(gchroma)
