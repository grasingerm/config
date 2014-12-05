alias cmakedebug='cmake $1 -DCMAKE_BUILD_TYPE=DEBUG'
alias cmakerelease='cmake $1 -DCMAKE_BUILD_TYPE=RELEASE'

export CC="clang"
export CXX="g++"
export CXXSTD="c++11"
export CSTD="c11"
export COPT="-O3"
export CXXOPT="-O3"
export CFLAGS="-Wall -Wextra -g -pedantic -pedantic-errors ${COPT} -std=${CSTD}"
export CXXFLAGS="-Wall -Wextra -g -pedantic -pedantic-errors ${CXXOPT} -std=${CXXSTD}"

export EDITOR="subl"
