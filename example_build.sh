#!/bin/sh
# Builds PlanarRad. Has one option input, the install dir

# create configure script - has been be done already so commented out
# ./autogen.sh
export JUDE2DIR=${1:-$HOME/jude2_install}
export LD_LIBRARY_PATH=$JUDE2DIR/lib:$LD_LIBRARY_PATH
export PATH=$JUDE2DIR/bin:$PATH


# make a directory to build in
rm -rf build
mkdir -p build


touch src/aclocal.m4 src/Makefile.am src/configure src/Makefile.in

# change to that directory
cd build

# to build command line version only without qt use option --disable-qt
# remove --enable-optimised=yes to build without optimisation flags (may solve build problems but will run slower)
../src/configure --prefix=$JUDE2DIR --enable-optimised=yes --enable-openmp CFLAGS="-fopenmp" 

# compile
make -j $(nproc)

# copy to $JUDE2DIR, if under /usr/local you probably need root priviliges
# so if this fails try 'sudo make install'
make install


