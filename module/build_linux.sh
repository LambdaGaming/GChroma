#!/bin/bash
cmake ./ -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DNO_EXCEPTIONS=ON
cmake --build . --clean-first
echo "Finished"
