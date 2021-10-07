#!/bin/bash

# this is intended to run on a 64-bit machine

cd vldp2 || exit
./configure --disable-accel-detect --build=`uname -p` || exit
make -j4 -f Makefile.linux_x64 || exit
cd ../game/singe
make -j4 -f Makefile.linux_x64 || exit
cd ../..
ln -sf Makefile.vars.linux_x64 Makefile.vars
make -j4 || exit

