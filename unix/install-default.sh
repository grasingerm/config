#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Please pass repository type as argument, i.e. trusty"
  exit 1
fi

echo "Adding virtualbox to repository..."
echo "deb http://download.virtualbox.org/virtualbox/debian $1 contrib" | sudo tee /etc/apt/sources.list
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

echo "Adding julia to repository..."
sudo apt-add-repository ppa:staticfloat/juliareleases

echo "Adding spotify to repository..."
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2C19886
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install  \
  chromium-browser    \
  spotify-client      \
  freemind            \
  texlive-full        \
  luatex              \
  texstudio           \
  vim                 \
  sublime-text        \
  sqlite3             \
  sqlitebrowser       \
  mysql-client        \
  mysql-client-5.6    \
  mysql-server-5.6    \
  mysql-workbench     \
  git                 \
  git-gui             \
  make                \
  cmake               \
  python2.7           \
  python-pysqlite2    \
  python-numpy        \
  python-yaml         \
  python-matplotlib   \
  python-dateutil     \
  idle-python2.7      \
  python3.4           \
  python3-dateutil    \
  python3-yaml        \
  python3-numpy       \
  python3-matplotlib  \
  python3-numexpr     \
  python3-sql         \
  python3-apsw        \
  python-vtk          \
  python-pyvtk        \
  idle-python3.4      \
  ruby2.0             \
  ruby-narray         \
  ruby-gsl            \
  ruby-distribution   \
  apache2             \
  php5                \
  php5-curl           \
  php5-json           \
  php5-mysql          \
  php5-sqlite         \
  php-pear            \
  phpunit             \
  octave              \
  r-base              \
  r-base-dev          \
  gnuplot             \
  gnuplot-x11         \
  oaklisp             \
  mit-scheme          \
  ghc                 \
  libghc-hmatrix-dev  \
  paraview            \
  gcc-4.8             \
  g++-4.8             \
  clang-3.5           \
  clang-format-3.5    \
  clang-modernize-3.5 \
  gdb                 \
  gdb64               \
  valgrind            \
  valkyrie            \
  kcachegrind         \
  tau                 \
  google-perftools    \
  libgoogle-perftools-dev \
  libgoogle-perftools4    \
  graphviz            \
  gv                  \
  cppcheck            \
  openmpi-bin         \
  libopenmpi-dev      \
  libopenmpi1.6       \
  libopencv-dev       \
  libopencv-gpu-dev   \
  libopencv-gpu2.4    \
  libopencv-core2.4   \
  libgsl0-dev         \
  libgsl0-dbg         \
  gsl-bin             \
  libgsl0ldbl         \
  libgtest-dev        \
  libvtk6             \
  libvtk6-dev         \
  libsqlite3-0        \
  libsqlite3-dev      \
  libmysqlclient-dev  \
  libmysqlclient18    \
  libgtk-3-0          \
  libgtk-3-dev        \
  libgtksourceview-3.0-1    \
  libgtksourceview-3.0-dev  \
  libcairo2           \
  libcairo2-dev       \
  libyaml-cpp-dev     \
  libyaml-cpp0.3      \
  libjson-c-dev       \
  libjansson-dev      \
  libjansson4         \
  libblas-dev         \
  libblas3            \
  libatlas3-base      \
  liblapack-dev       \
  liblapack3          \
  libeigen3-dev       \
  libarpack2-dev      \
  libarpack2          \
  libarmadillo-dev    \
  libarmadillo4       \
  libboost1.55-all-dev\
  virtualbox-5.0      \
  julia               \


echo "Installing default julia v0.3.x packages..."
julia julia/install_and_update_default_pkgs.jl DefaultPkgs3.txt
  
echo "Downloading and installing rstudio..."
URL='https://download1.rstudio.org/rstudio-0.99.465-i386.deb'; FILE=`mktemp`;
wget "$URL" -qO $FILE && sudo dpkg -i $FILE; rm $FILE

echo "Removing firefox..."
sudo apt-get remove firefox
