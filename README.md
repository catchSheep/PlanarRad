# PlanarRad Fork 

This github is an attempt to update and marginally maintain the version of John Hedley's PlanarRad software, which he graciously licensed under the GNU GPLv3.0.


# Notes on Installation and building:


## Linux Installation
Installation on Linux should be fairly easy and straightforward.   

Download this repo either as a zip and extract it, or clone the repo with `git clone`.

QT Dependencies should be removed, at the expense of the GUI. 


---------------------------
## Initial steps
You will need to download the package dependencies. Try the below commands for your OS:
### Ubuntu 22.04 specific packages
```
sudo apt-get install g++  libsm-dev libjpeg-dev libboost-all-dev 
```
### Fedora specific packages
```
sudo yum install gcc gcc-c++ libjpeg-devel boost-devel
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
If you wish for these to initialise on a login, add them to your `~/.bashrc` file (or ~/.zshrc if you use zsh).  
Then restart your terminal environment with `source ~/.bashrc`

With the prerequisite packages installed and the path set, simply navigate to the main directory in a terminal run the install script `example_build`:
```
bash example_build
```
## Windows/OS X Installation
If you're on windows or OS X, it's up to you to fend for yourself. 

For windows users, you may be able to get away with using and running it through WSL (Windows subsystem for Linux - many guides online). 

If on Mac, you may need brew to install some dependencies.

# Misc Installation Notes
## A note on downloading from github
If you download the files from github, likely the timestamps have all reset due to how git works. This upsets autotools immensly, as it may think the aclocal.m4 and other files are out of date and need to be regenerated. If you have this issues with building manually, before running configure run a simple:
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
 * Complete documentation for the specifics of each command line program
 * Containerize (docker/podman/apptainer)
 * Create useful pre-commits and actions for repo
 * Re-organise repo files
 * Automated testing
 * Create new GUI
Feel free to contribute!


For the old reame, see [the OLD_REAME.md](OLD_REAME.md)