#!/bin/bash

set -x

# Check if debug mode is enabled
DEBUG_MODE=${1:-false} # assign first argument to DEBUG_MODE, default to false if not provided

if [ "$DEBUG_MODE" = "debug" ] || [ "$DEBUG_MODE" = "gdb" ]; then
    echo "Building in Debug mode for gdb debugging..."
    ./build.sh Debug
    BUILD_DIR="cmake-build-debug"
else
    echo "Building in Release mode..."
    ./build.sh Release
    BUILD_DIR="cmake-build-release"
fi

# compile sc and generate executable code for ${run_file} to run
/usr/bin/cmake --build ./${BUILD_DIR} --target demo_llm_run -- -j 6

run_file=./${BUILD_DIR}/src/demo_llm_run

if [ "$DEBUG_MODE" = "debug" ] || [ "$DEBUG_MODE" = "gdb" ]; then
    echo "Running with gdb debugger..."
    gdb --args ${run_file}
else
    echo "Running normally..."
    ${run_file}
fi 