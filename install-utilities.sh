#!/bin/bash

mkdir build
cd build
cmake ../utilities/ -DCMAKE_BUILD_TYPE=release
make
sudo cp ./bin/* /usr/local/bin/
cd ../
sudo rm -R build
echo "utilities install in /usr/local/bin/"
