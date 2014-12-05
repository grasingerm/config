cmake_minimum_required(VERSION 2.8)

project(personal_utilities)

# set C standards
set(STDC c11)
set(STDCXX c++1y)

if( NOT CMAKE_BUILD_TYPE )
  set( CMAKE_BUILD_TYPE release CACHE STRING
       "Choose the type of build, options are: None Debug Release RelWithDebInfo
        MinSizeRel."
       FORCE )
endif()

set(CMAKE_C_FLAGS_DEBUG "-Wall -Wextra -g -std=${STDC} -pedantic -pedantic-errors")
set(CMAKE_C_FLAGS_RELEASE "-Wall -Wextra -g -std=${STDC} -pedantic -pedantic-errors -O3")
set(CMAKE_CXX_FLAGS_DEBUG "-Wall -Wextra -g -std=${STDCXX} -pedantic -pedantic-errors")
set(CMAKE_CXX_FLAGS_RELEASE "-Wall -Wextra -g -std=${STDCXX} -pedantic -pedantic-errors -O3")

# build directories
set(CMAKE_BINARY_DIR build)
set(EXECUTABLE_OUTPUT_PATH bin)

# dependencies
add_executable(ewnl end_with_newline.c)

install(TARGETS ewnl DESTINATION bin)
