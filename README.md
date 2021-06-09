# PlanarRad Fork 

This github is an attempt to update and marginally maintain the version of John Hedley's PlanarRad software, which he graciously licensed under the GNU GPLv3.0.


# Notes on Installation and building:


## Linux Installation
Installation on Linux should be fairly easy and straightforward.   

Currently, to compile, we compile with the QT dependencies, even if you only want the command line features. The --disable-qt option does NOT appear to work, as there are many calls to qt libraries within the code that are not removed by the use of such a flag. See todo list.   

Tested on Fedora 33 and 34.

---------------------------
## Initial steps
You will need to download the package dependencies. Try the below commands for your OS:
### Ubuntu specific packages
(NB: QT dependence isnt tested on ubuntu. If this doesnt work, try a different qt package)
```
sudo apt-get install g++ libqt4-dev libsm-dev libjpeg-dev libboost-all-dev qt5-default qtbase5-dev
```
### Fedora specific packages
```
sudo yum install gcc gcc-c++ qt-devel libjpeg-devel boost-devel qt5-qtbase qt5-qtbase-devel
```
---------------------------

## Installation
### General
On Ubuntu add something like the following to the end of the '.profile' file in your home directory. On Fedora add it to the end of the  '.bash_profile' file in your home directory. You may be able to get away with adding them to the start of the `example_build` script.
```
export JUDE2DIR=$HOME/jude2_install
export LD_LIBRARY_PATH=$JUDE2DIR/lib:$LD_LIBRARY_PATH
export PATH=$JUDE2DIR/bin:$PATH
```

Then restart your terminal environment. The fastest and most pain-free way may be to simply log in and out quickly.

With the prerequisite packages installed and the path set, simply run the install script example_build:
```
bash example_build
```
or
```
./example_build
```
## Windows/OS X Installation
If you're on windows or OS X, it's up to you to fend for yourself. 

For windows users, you may be able to get away with using and running it through WSL (Windows subsystem for Linux - many guides online). 

If on Mac, you may need brew to install some dependencies.

# Misc Installation Notes
## A note on downloading from github
If you download the files from github, likely the timestamps have all reset due to how git works. This upsets autotools immensly, as it may think the aclocal.m4 and other files are out of date and need to be regenerated. To solve this, before running configure we run a simple:
```
touch aclocal.m4 Makefile.am configure Makefile.in
```
This will correctly fool autotools into thinking that the files are up to date, which should fix the issue. This is run before `configure`  in `example_build`. NB: If you **DO** edit aclocal makefile's, etc, you will need to re-run autotools as mentioned above.  

Bear all this in mind if you want to run the `./configure`, `make`, `make install` yourself.

## Multithreaded compiling
PlanarRad now comes with OpenMP support. Should automatically come with multithreaded compilation. To prevent this, either remove `--enable-openmp CFLAGS="-fopenmp"` from the example_build script, or after installation, simply set the OpenMP environment variable OMP_NUM_THREADS to the maximum number of threads you want before running PlanarRad, eg:
```
export OMP_NUM_THREADS=1
```

## Re-generating build files with autotools
When wanting to produce build files, ie if you need additional compiler options, if you've edited the Makefile.am's etc., just run:
```
libtoolize --force --install -c
rm aclocal.m4
aclocal
autoheader
automake --force --add-missing -c
autoreconf --force --install
```
NB: It is recommended to have an up to date `autotools`, `libtool`, and `autoconf` when performing the above
## TODO:
 * Remove qt dependence
 * Complete documentation for the specifics of each command line program
Feel free to contribute!




## Old Readme from the 0.9.5beta (2015)
------------------------------------------------------
PlanarRad 0.9.1beta (Jude 2.1.0 library)
(c) 1999-2013 John Hedley

Prerequisites
-------------

The tools automake, autoconf and libtool must be installed to build PlanarRad.
These are usually already installed on most systems.

The Boost library must also be installed, again it most likely already is.

Qt is required for the GUI tools to be built, but not for the command line versions.

On Ubuntu libsm-dev might need to be installed.


Fixing Compilation On Newer Distros
-----------------------------------

The compilation process needs to know where various components of QT are, the autoconf scripts are not very good at finding these. The easiest way is to make a directory "qt4" and in it make symlinks to required components. For example on Ubuntu 12.10:

mkdir qt4
cd qt4
ln -s /usr/bin bin
ln -s /usr/include/qt4 include
ln -s /usr/lib/x86_64-linux-gnu lib

So it looks like this:

$ ls -l qt4
total 0
lrwxrwxrwx 1 user user  8 Jul 12 10:59 bin -> /usr/bin
lrwxrwxrwx 1 user user 16 Jul 12 11:14 include -> /usr/include/qt4
lrwxrwxrwx 1 user user 25 Jul 12 11:08 lib -> /usr/lib/x86_64-linux-gnu

Then edit 'example_build' so that the configuration points to the full path to qt4. For example there should be a line like this:

../configure --prefix=/usr/local/jude_test --with-qtdir=/home/user/jude2/qt4

Be sure to use the full path starting with a '/' otherwise it won't work.

On Fedora 19 the layout is a bit different and the QT executable tools are called something different so must be invidually symlinked inside a directory called "bin". Should look like this:

$ ls -l /usr/local/qt4/
total 4
drwxr-xr-x. 2 root root 4096 Sep  2 00:30 bin
lrwxrwxrwx. 1 root root   12 Sep  2 00:19 include -> /usr/include
lrwxrwxrwx. 1 root root   10 Sep  2 00:21 lib -> /usr/lib64
$ ls -l /usr/local/qt4/bin/
total 0
lrwxrwxrwx. 1 root root 16 Sep  2 00:23 moc -> /usr/bin/moc-qt4
lrwxrwxrwx. 1 root root 18 Sep  2 00:22 qmake -> /usr/bin/qmake-qt4
lrwxrwxrwx. 1 root root 12 Sep  2 00:30 rcc -> /usr/bin/rcc
lrwxrwxrwx. 1 root root 16 Sep  2 00:23 uic -> /usr/bin/uic-qt4


Very Quick installation
-----------------------

The script file 'example_build' will build and test the code ready for installation.
To change where the files will be installed edit 'example_build' and change the configure option

--prefix=/usr/local/jude_test

to whatever directory you want to be the base of the installation.
All installed files will be put there.

After running example_build you need to type:

cd build
make install

to actually copy the built files to the installation location.
This may need to be done with superuser priviliges depending on the installion directory location.


Quick installation
------------------

Change to the top level directory (i.e the one where this file is).
Then type:

./autogen.sh
mkdir build
cd build
../configure
make
make install

To specify where things are installed, and also to specify the location of QT arguments 
such as the following can be supplied to ./configure instead of what is shown above.

./configure --prefix=/usr/local --bindir=/usr/local/bin --with-qtdir=/usr/local/qt

To build the command line tools only without the requiremnet for QT supply the option

--disable-qt

instead of the --with-qtdir option.

if you have doxygen installed the source code documentation can be built by typing:

doxygen doxygen.cfg

It can then be found in in the directory 'docs'. At the time of writing it is not very complete.


Testing
-------

Each library or tool may have an associated test program which can be found in directory 
'build/<libname>/testing'. So for example, to run tests for jude::base library.

cd build/base/testing
./test_base

A script is provided to run all the provided test programs at once.

cd build/testing
./test_script

Sometimes tests will fail but it's not a problem. This is especially true of test in the base 
library that are to do with number representations. Usually the failures are just due to 
rounding errors on the least-significant bits.


Building HydroLight Comparison Document
---------------------------------------

This requires that the system has gnuplot and latex installed, on Ubuntu install texlive-latex-extra.

First make sure the environmental variable JUDE2DIR is set to where the bin directory containg the planarrad_free executable can be found.
For example do this:

export JUDE2DIR=/usr/local/jude_test

(Or you can add this to your .bash_profile file)

Which would mean the executable is at /usr/local/jude_test/bin/planarrad_free

Then find the testing directory in the planarrad source files and run the process script:

cd testing/slabtool_test02
./process

It takes about an hour or so but the result is the file "pl_hr_compare.pdf" which shows many plots of a set of HydroLight runs, found under testing/slabtool_test02/hl_original_data, and the equivalent PlanarRad runs. They should show more or less exact correspondence, except where values are very small. There are some small differences for wind blown water surfaces (reason unknown).
