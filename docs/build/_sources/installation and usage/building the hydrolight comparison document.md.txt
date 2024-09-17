# Building the HydroLight comparison Document
The PlanarRad source code distribution for Linux contains a set of scripts for self-testing the code by building a Hydrolight comparison document. This document verifies that PlanarRad is correctly installed and also demonstrates that PlanarRad does indeed produce the same outputs as Hydrolight. The PlanarRad source distribution contains some data files generated from runs of Hydrolight under a wide range of numerical conditions, including single scattering albedos from zero to one. The test script runs the same model configurations for PlanarRad and extracts the data from both the PlanarRad outputs and the stored Hydrolight output files and generates numerous plots. The plots are assembled into a pdf for visual review.

First we assume that PlanarRad has been successfully compiled as described under: [Installation from source on Linux](installation.md). Now the scripts to build the comparison document require some additional packages to be installed, specifically concerned with LaTeX and gnuplot.

On Ubuntu 13.04 (or similar):
```
sudo apt-get install gnuplot texlive-latex-extras
```
On Fedora 19 (or similar):
```
sudo yum install gnuplot texlive texlive-latex texlive-changepage
```
The document generation scripts are in the 'testing/slabtool_test02' subdirectory of the the source. The scripts use the environmental variable JUDE2DIR to find the executables, so ensure that this set as described on the page [Installation from source on Linux](installation.md).

So, from the directory planarrad_free_src_0.9.2beta_2013_11_17 (for example) type:
```
cd testing/slabtool_test02 
./process
```
It will take quite a while to perform all the runs. Depending on the machine could be up to half an hour. At a certain point it may complain about the font Arial not being available but another font will be substituted and it's not a problem. At the end there should be a file created called 'pr_hl_compare.pdf'. You can download the example I have just created while writing this. It is the essentially the correct output so gives an idea what to expect. 