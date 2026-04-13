#!/bin/bash
rm CMakeCache.txt
cmake ./ -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DNO_EXCEPTIONS=ON -DCMAKE_BUILD_TYPE=Release
cmake --build . --clean-first
echo "Finished"
