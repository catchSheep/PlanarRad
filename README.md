# PlanarRad  

PlanarRad is free software for modelling light in natural waters or other homegenous scattering and absorbing media. It is functionally similar to the commercial software Hydrolight. 


This github is an attempt to update and marginally maintain John Hedley's PlanarRad software, which he graciously licensed under the GNU GPLv3.0. 

Due to QT (GUI library) compatibility issues, this fork currently only supports command-line interaction, and has no GUI.




# Installation

---------------------------
## Building from source
#### Install Dependencies
You will need to download the package dependencies. Some example for certain OS's are below.
##### Ubuntu 22.04 and 24.04 specific packages
```
sudo apt-get install g++ libsm-dev libjpeg-dev libboost-all-dev make
```
##### Fedora (34?) specific packages
```
sudo yum install gcc gcc-c++ libjpeg-devel boost-devel make
```

#### Set install location(s)
On Ubuntu add something like the following to the end of the `~/.bashrc` file in your home directory (or add it to `~/.zshrc` for zsh). 
```
export JUDE2DIR=$HOME/jude2_install
export LD_LIBRARY_PATH=$JUDE2DIR/lib:$LD_LIBRARY_PATH
export PATH=$JUDE2DIR/bin:$PATH
``` 
Then reload your terminal environment with `source ~/.bashrc`

With the prerequisite packages installed and the path set, simply navigate to the main directory in a terminal run the install script `example_build`:
```
bash example_build $JUDE2DIR
```
### 👩‍💻 Windows/OS X
If you're on windows or OS X, it's up to you to fend for yourself. 

For windows users, you may be able to get away with using and running it through WSL (Windows subsystem for Linux - many guides online). 

If on Mac, you may need brew to install some dependencies.

### 📜 A note on downloading from github
If you download the files from github, likely the timestamps have all reset due to how git works. This upsets autotools immensly, as it may think the aclocal.m4 and other files are out of date and need to be regenerated. If you have this issue when building manually, then before running configure run a simple:
```
touch src/aclocal.m4 src/Makefile.am src/configure src/Makefile.in
```
This will correctly fool autotools into thinking that the files are up to date, which should fix the issue. This is run before `configure`  in `example_build`. NB: If you **DO** edit aclocal makefile's, etc, you will need to re-run autotools as mentioned above.  

Bear all this in mind if you want to run the `./configure`, `make`, `make install` yourself.

### 🕸 Multithreaded compiling
PlanarRad now comes with OpenMP support. The default build script `example_build.sh` automatically comes with multithreaded compilation. To prevent this simply set the OpenMP environment variable OMP_NUM_THREADS to the maximum number of threads you want before running PlanarRad. 

There is some non-parallel overhead in the multithreaded program, so it is recommended to turn off multi-threading if you are batching large numbers of program runs across across cores/nodes, as then you will have better throughput.   

Otherwise it is recommended to keep it on to reduce runtime (i.e. reduce the latency of a run).

To change number of threads, use the environment variable `OMP_NUM_THREADS`, e.g. for only one run you can use:
```
OMP_NUM_THREADS=1 <PlanarRad command>
```
Alternatively, turn off multi-threaded support during build. Do this by not including `--enable-openmp CFLAGS="-fopenmp"` in the configure command (see [`example_build.sh`](example_build.sh)).

## 🐋 Docker installation
NB: Pre-alpha, not ready for user testing  
🔥 NB: Installation via Docker will currently not work with the test scripts, as they work with planarRad binaries (slabtool_free etc) directly. Use this method if you have issues with other installation methods.



### Non-root docker installation
To build a docker image with the PlanarRad executables, in the main repository directory run:
```sh
docker build . -t planarrad
```
On a rootless docker install, to print the help command, run:
```
docker run planarrad -h
```
On a rootless docker install, to run slabtool:
```
docker run planarrad slabtool <command>
```
You will also need to mount a data volume after `run` but before `planarrad` with `-v src:insde_container_dest`. Paths sent to the tool via CLI will be paths inside the container.

# Usage
Currently, please see the [PlanarRad wiki](http://www.planarrad.com/) for general usage.

To build the HydroLight comparison document, 

# Building with changes
When wanting to produce build files, ie if you need additional compiler options, if you've edited the Makefile.am's etc., just run 
```
cd src
bash autoconf_setup.sh
```
Which should rebuild all the GNU autoconf files
NB: It is recommended to have an up to date `autotools`, `libtool`, and `autoconf` when performing the above

# TODO:
 * Complete documentation for the specifics of each command line program
 * CBuild appimage
 * Create useful pre-commits and actions for repo
 * Re-organise repo files
 * Automated testing
 * Create new GUI/ add back in old GUI in a more maintable/installable way (appimage?)
Feel free to contribute!

# See also
PlanarRadpy by marrabld, a GUI allowing batch scripting of PlanarRad
https://github.com/marrabld/planarradpy

For the old reame, see [the OLD_REAME.md](OLD_REAME.md)
