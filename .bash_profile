#!/bin/bash

export CC="clang"
export CXX="g++"
export CXXSTD="c++11"
export CSTD="c11"
export COPT=""
export CXXOPT=""
export CFLAGS="-Wall -Wextra -g -pedantic -pedantic-errors ${COPT} -std=${CSTD}"
export CXXFLAGS="-Wall -Wextra -g -pedantic -pedantic-errors ${CXXOPT} -std=${CXXSTD}"

export EDITOR="vim"