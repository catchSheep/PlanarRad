
# Installation
To use PlanarRad, first choose an installation method:
- build locally
- prebuilt appimage
- build (docker) container

## Building from source
### Install Dependencies
You will need to download the package dependencies. Some example for certain OS's are below.
#### Ubuntu 22.04 and 24.04 specific packages
```
sudo apt-get install g++ libsm-dev libjpeg-dev libboost-all-dev make
```
#### Fedora/RHEL/etc specific packages
```
sudo yum install gcc gcc-c++ libjpeg-devel boost-devel make
```
#### 👩‍💻 Windows/OS X
If you're on windows see [Windows Installation](windows_install.md).
or OS X, it's up to you to fend for yourself. 

For windows users, you may be able to get away with using and running it through WSL (Windows subsystem for Linux - many guides online). 

If on Mac, you may need brew to install the dependencies.

### Set install location(s)
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


### 📜 A note on downloading from github
If you download the files from github, sometimes the timestamps will all reset (due to how git works). This upsets autotools immensly, as it may think the aclocal.m4 and other files are out of date and need to be regenerated. If you have this issue when building manually, then before running configure run a simple:
```
touch src/aclocal.m4 src/Makefile.am src/configure src/Makefile.in
```
This will correctly fool autotools into thinking that the files are up to date, which should fix the issue. This is run before `configure`  in `example_build`. NB: If you **DO** edit aclocal makefile's, etc, you will need to re-run autotools as mentioned above.  

Bear all this in mind if you want to run the `./configure`, `make`, `make install` yourself.

### 🕸 Multithreaded compiling
PlanarRad now comes with OpenMP support. The default build script `example_build.sh` automatically comes with multithreaded compilation.
There is some non-parallel overhead in the multithreaded program, so it is recommended to turn off multi-threading if you are batching large numbers of program runs across across cores/nodes, as then you will have better throughput. For a single-run, keep it on for faster latency.   

To change number of threads, set the environment variable `OMP_NUM_THREADS` at runtime, e.g. for only one run you can use:
```
OMP_NUM_THREADS=1 <PlanarRad command>
```
Alternatively, `export` the enviornment variable, or turn off multi-threaded support during build. Turn it off during build by not including the `--enable-openmp CFLAGS="-fopenmp"` flags in the configure command (see `example_build.sh`).

## 🐋 Docker installation

🔥 NB: Pre-alpha, not ready for user testing. Installation via Docker will currently not work with the test scripts, as they work with planarRad binaries (slabtool_free etc) directly. Use this method if you have issues with other installation methods.  

In the main repo directory, build and run the image with:
```
docker build . -t planarrad
docker run -v src:/data planarrad <planarrad command>
```
Note that this will map the `src` directory on your computer (replace with your chosen directory) with the `/data` directory in the docker container. Make sure your chosen planarrad command (e.g. `slabtool blah blah...` ) is reading and writing to the mounted volume in /data.  

Additionally, check if you are on a root installation of docker with:
```
docker version | grep rootlesskit
```
If you are on a root install (usually the default), on linux preserve user permissions with generated files by mapping your user id to the docker container with `--user $(id -u):$(id -g)` after `docker run`, e.g.:
```
docker run --user $(id -u):$(id -g) -v src:/data planarrad <planarrad command>
```