@echo off
rem Build dll
cmake ./ -DCMAKE_POSITION_INDEPENDENT_CODE=ON
cmake --build . --clean-first --config Release

rem Move and rename binary
cd Release
ren "gmsv_gchroma_win64.dll" "gmcl_gchroma_win64.dll"
copy "gmcl_gchroma_win64.dll" ".."
cd ..

rem Cleanup all the crap
del /S *.sln
del /S *.vcxproj*
del /S *.cmake
del CMakeCache.txt
rmdir /s /Q CMakeFiles
rmdir /s /Q Release
rmdir /s /Q x64
rmdir /s /Q ALL_BUILD.dir
rmdir /s /Q INSTALL.dir
rmdir /s /Q gchroma.dir
rmdir /s /Q ZERO_CHECK.dir
@echo Finished
