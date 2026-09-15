cmake_minimum_required(VERSION 3.10)

project(gchroma-project LANGUAGES CXX)

set(CMAKE_CONFIGURATION_TYPES Release Debug)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(dir ${CMAKE_CURRENT_SOURCE_DIR}/build)
set(FETCHCONTENT_BASE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/build/_deps)

include(FetchContent)
FetchContent_Declare(
	orgbsdk
	GIT_REPOSITORY https://github.com/Youda008/OpenRGB-cppSDK
	GIT_TAG 12159516e47da6b56bac669b7daaa266a615e2de)
FetchContent_MakeAvailable(orgbsdk)

FetchContent_Declare(
	gmod-module-base
	GIT_REPOSITORY https://github.com/Facepunch/gmod-module-base
	GIT_TAG e0156e5f96cd0bad8eed738f0d20e2c9a14b2a0d)
FetchContent_MakeAvailable(gmod-module-base)

add_library(gchroma SHARED)
target_sources(gchroma PRIVATE main.cpp)
target_link_libraries(gchroma gmod-module-base orgbsdk)

set_gmod_suffix_prefix(gchroma)
