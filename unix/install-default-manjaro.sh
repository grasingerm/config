#!/bin/bash

# install spotify
yaourt -S libgcrypt15 ffmpeg-compat spotify --needed --noconfirm

sudo pacman -S     chromium                   \
                   evince                     \
                   vim                        \
                   tmux                       \
                   htop                       \
                   git                        \
                   gitg                       \
                   qgit                       \
                   openssh                    \
                   gcc-fortran                \
                   colorgcc                   \
                   clang                      \
                   tcc                        \
                   cmake                      \
                   gdb                        \
                   kdbg                       \
                   valgrind                   \
                   valgrind-multilib          \
                   alleyoop                   \
                   openmpi                    \
                   hdf5-openmpi               \
                   hdf5                       \
                   lapack                     \
                   arpack                     \
                   blas                       \
                   cblas                      \
                   gsl                        \
                   eigen                      \
                   boost                      \
                   boost-libs                 \
                   libyaml                    \
                   yaml-cpp                   \
                   jansson                    \
                   yajl                       \
                   json-c                     \
                   jsoncpp                    \
                   json-glib                  \
                   sqlite                     \
                   sqlitebrowser              \
                   libmariadbclient           \
                   mariadb                    \
                   python                     \
                   python-pip                 \
                   cython                     \
                   python2                    \
                   python2-pip                \
                   cython2                    \
                   julia                      \
                   clisp                      \
                   bigloo                     \
                   ghc                        \
                   chicken                    \
                   gdc                        \
                   ldc                        \
                   texstudio                  \
                   texlive-bin                \
                   texlive-core               \
                   texlive-bibtexextra        \
                   texlive-fontsextra         \
                   texlive-formatsextra       \
                   texlive-langextra          \
                   texlive-latexextra         \
                   texlive-plainextra         \
                   texlive-science            \
                   texlive-genericextra       \
                   texlive-htmlxml            \
                   r                          \
                   vtk                        \
                   gnuplot                    \
                   virtualbox                 \
                   skype                      \
                   boinc

yaourt -S          massif-visualizer          \
                   paraview                   \
                   visit-bin                  \
                   armadillo                  \
                   scalapack                  \
                   rstudio-desktop-bin 

# update everything...
sudo pacman -Suy
sudo yaort -Syua

# install python modules
sudo pip install numpy matplotlib dateutil yaml idle
sudo pip2 install numpy matplotlib dateutil yaml idle

# install julia modules
pushd ~/Dev/config/julia
julia ./install_and_update_default_pkgs.jl DefaultPkgs3.txt
popd
