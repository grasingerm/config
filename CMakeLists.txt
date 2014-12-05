cmake_minimum_required(VERSION 2.8)

project(adfda)

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
set(CMAKE_C_FLAGS_RELEASE "-Wall -Wextra -std=${STDC} -pedantic -pedantic-errors -O3")
set(CMAKE_CXX_FLAGS_DEBUG "-Wall -Wextra -g -std=${STDCXX} -pedantic -pedantic-errors")
set(CMAKE_CXX_FLAGS_RELEASE "-Wall -Wextra -std=${STDCXX} -pedantic -pedantic-errors -O3")

# build directories
set(CMAKE_BINARY_DIR build)
set(EXECUTABLE_OUTPUT_PATH bin)

# include and link directories
# 
# i.e. ...
# include_directories(../include)
# include_directories(../../share)
# link_directories(../src)

# dependencies
add_executable(some_executable some_source_files.cpp)

# link libraries
# target_link_libraries(some_executable some_library)
target_link_libraries(some_executable -lprofiler)

# uncomment if using the standard c math library
# if (UNIX)
#     target_link_libraries(some_executable m)
# endif (UNIX)

install(TARGETS some_executable DESTINATION bin)
