#!/bin/bash

echo "Adding spotify to repository..."
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2C19886
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install  \
  tmux                \
  spotify-client      \
  htop                \
  texlive-full        \
  luatex              \
  texstudio           \
  vim                 \
  sqlite3             \
  sqlitebrowser       \
  git                 \
  git-gui             \
  make                \
  cmake               \
  python              \
  python-pip          \
  python3             \
  python3-pip         \
  gnuplot             \
  oaklisp             \
  ghc                 \
  libghc-hmatrix-dev  \
  paraview            \
  colorgcc            \
  gfortran            \
  g++	              \
  clang               \
  lldb                \
  clang-format        \
  tcc                 \
  gdb64               \
  valgrind            \
  valkyrie            \
  kcachegrind         \
  google-perftools    \
  libgoogle-perftools-dev \
  graphviz            \
  cppcheck            \
  openmpi-bin         \
  libopenmpi-dev      \
  libopenmpi1.10      \
  libgsl-dev          \
  libgsl2             \
  gsl-bin             \
  libsqlite3          \
  libsqlite3-dev      \
  libyaml-cpp-dev     \
  libyaml-cpp0.5v5    \
  libblas-dev         \
  libblas3            \
  libatlas3-base      \
  liblapack-dev       \
  liblapack3          \
  libeigen3-dev       \
  libarpack2-dev      \
  libarpack2          \
  libarmadillo-dev    \
  libarmadillo6       \
  libscalapack-mpi-dev\
  libscalapack-mpi1   \
  libboost-all-dev    \
  julia               \
  vpnc                \
  p7zip-full

echo "Installing python modules..."
sudo pip install numpy matplotlib dateutil pyyaml
sudo pip3 install numpy matplotlib dateutil pyyaml

echo "Installing default julia v0.5.x packages..."
pushd ~/Shared/Dev/config/
julia julia/install_and_update_default_pkgs.jl DefaultPkgs5.txt
popd
  
echo "Removing firefox..."
sudo apt-get remove firefox
