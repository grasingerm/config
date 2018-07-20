#!/bin/bash

sudo cp -v utilities/countlines /usr/local/bin

mkdir build
cd build
cmake ../utilities/ -DCMAKE_BUILD_TYPE=release
make
sudo cp -v ./bin/* /usr/local/bin/
cd ../
sudo rm -R build
echo "utilities installed in /usr/local/bin/"
