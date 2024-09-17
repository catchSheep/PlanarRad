# Usage

The currently supported ways to use PlanarRad are:
- build and install binaries from source

See [installation](installation.md) for more information.

## Binaries built from source

PlanarRad contains several commands installed to the system path. These are:
- slabtool_free
- calctool_free
- filetool_free
- phasetool_free
- skytool_free
- surftool_free
- wltool_free

While normally you'll only need slabtool_free, if you're an adnvanced user, for more information on run each program with the `--help` command

## Command line running (Linux)
PlanarRad can be run from the command line without opening the GUI window, the run parameters are specified in a simple text file. The executable for command line running is called 'slabtool_free', and if the parameters are saved in the file 'params.txt' then under Linux it is run like this:
```
slabtool_free params=params.txt
```
Assuming 'slabtool_free' is in your path. Note there are no spaces around the '='.

The GUI version of PlanarRad automatically builds files for: 1) sky radiance distribution; 2) the air-water interface; and 3) the phase function, as determined from the settings. However, the command line version requires these files to be pre-built and the paths to them are specified in the input text file. The easiest way to build these files is to run the GUI version of PlanarRad with required settings and the files can be found in the output directory.

For example, following the example here: [BRDF of a material with isotropic phase function](BRDF_isotropic.md), gives rise to these files:
```
iface_rdd_HL18x24_1 
input_rd_HL18x24_1
pf_rdd_HL18x24_1
```
Which are binary files that tabulate the air-water interface, sky radiance and phase function as used in that run.

To perform the same model run as described on the page BRDF of a material with isotropic phase function from the command line copy these three files to a new directory together with the band specification 'bands1.bsf' described on that page. Then create a file 'params.txt' to look like this:
```
name = test1

band_spec_fp = bands1.bsf

partition = sphere
vn = 18
hn = 24
theta_points = 0,5,15,25,35,45,55,65,75,85,90,95,105,115,125,135,145,155,165,175,180

depth = 20
sample_point_distance = 1
sample_point_delta_distance = 0.01

sky_fp = input_rd_HL18x24_1

water_surface_fp = iface_rdd_HL18x24_1 

pf_fp = pf_rdd_HL18x24_1

atten_data = 0.3
absorp_data = 0.2

bottom_reflec_diffuse_data = 0

report_save_fp = report.txt

verbose = 6
```
And then to run, `cd` to that directory and type:
```
slabtool_free params=params.txt
```
After the model has finished running the file `report.txt` will have been created in the directory, and should be the same as the report file produced by the GUI run described on the page BRDF of a material with isotropic phase function.

The most efficient way to use this system is to pre-build a set of sky radiances, interface functions and phase functions. A script can then invoke multiple runs combining these in any combination, together with attenuation, absorption, depth and bottom boundary reflectance, by producing a 'params.txt' file with the correct filenames and values in it. 

### Slabtool Help Output
Below is the output of the slabtool help
```
Output Band And Directional Structure Specification From Files
--------------------------------------------------------------
band_spec_fp  = <filepath>  (filepath of output band specification)
direc_spec_fp = <filepath>  (filepath of output directional structure specification)

Band And Directional Structure Direct Specification
---------------------------------------------------
All band and directional structure specifications can be given directly
in the supplied parameters rather than by reference to a file. In this case
the band specification and directional structure specification parameters
are given with an appropriate prefix to indicate to what they refer.

Output: (no prefix)
Parameters For Direct Band Specification
----------------------------------------
<prefix>bs_name           = <string>  (name of the band specification scheme)
<prefix>bs_code           = <string>  (short code to use to id band specification scheme)
<prefix>band_count        = <integer>  (number of bands)
<prefix>band_centres_data = <r0,r1,r2, ... rn>  (direct specification of band centres in nm)
<prefix>band_widths_data  = <r0,r1,r2, ... rn>  (direct specification of band widths in nm)
<prefix>band_centres_fp   = <filepath>  (path of file specifying band centres in nm)
<prefix>band_widths_fp    = <filepath>  (path of file specifying band widths in nm)
<prefix>preferred_default = yes | no  (request this be the default band specification in a gui context)

Parameters For Direct Directional Structure Specification
---------------------------------------------------------
<prefix>ds_name      = <string>  (name of the directional structure scheme)
<prefix>ds_code      = <string>  (short code to use to id full spherical versions directional structure scheme)
<prefix>partition    = sphere  (currently only spherical partitions are supported)
<prefix>storage      = table   (currently only table storage is supported, optional)
<prefix>vn           = <integer>  (number of vertical quads in a sphere excluding endcaps)
<prefix>hn           = <integer>  (number of horizontal quads)
<prefix>theta_points         = <r0,r1,r2, ... rn>  (theta values of vertical quad edges over full sphere, 0 to 180, optional)
<prefix>theta_points_fp      = <filename>  (file of theta values of vertical quad edges over full sphere, 0 to 180, optional)
<prefix>preferred_default    = yes | no  (request this be the default directional specification in a gui context)

Note if theta points are not specified a 'regular' directional structure is constructed. In this case all quads have the same
zenith angular height and the total end cap angle is also this angular size, equal to pi / (vn+1) radians.


Input Specification
-------------------
sky_fp                         = <filepath>
bottom_reflec_fp               = <filepath>   BRDF
bottom_reflec_diffuse_data     = <r1,r2, ... rn>   Lambertian direct specification
bottom_reflec_diffuse_fp       = <filepath>       Lambertian from file
bottom_reflec_diffuse_band_spec_fp       = <filepath>
depth = <real>
sample_point_distance = <real>
sample_point_list = <r1,r2, ... rn>
sample_point_delta_distance = <real>
atten_fp = <filepath>
atten_band_spec_fp = <filepath>
absorp_fp = <filepath>
absorp_band_spec_fp = <filepath>
scat_fp = <filepath>
scat_band_spec_fp = <filepath>
integrator   = euler | midpoint | runga4 | runga4adap
Saving Quad-Averaged Directional Radiance Outputs
-------------------------------------------------
Ld_a_save_fp       = <filepath>  (save downwelling spectral directional quad-averaged radiance above the water surface)
Lu_a_save_fp       = <filepath>  (save upwelling spectral directional quad-averaged radiance above the water surface)
Ld_w_save_fp       = <filepath>  (save downwelling spectral directional quad-averaged radiance just below the water surface)
Lu_w_save_fp       = <filepath>  (save upwelling spectral directional quad-averaged radiance just below the water surface)
Ld_b_save_fp       = <filepath>  (save downwelling spectral directional quad-averaged radiance at the water column bottom)
Lu_b_save_fp       = <filepath>  (save upwelling spectral directional quad-averaged radiance at the water column bottom)
Ld_it_save_fp      = <filepath>  (save downwelling spectral directional quad-averaged transmitted into water radiance)
Lu_it_save_fp      = <filepath>  (save upwelling spectral directional quad-averaged water-leaving radiance)
Ld_ir_save_fp      = <filepath>  (save downwelling spectral directional quad-averaged water underside reflected radiance)
Lu_ir_save_fp      = <filepath>  (save upwelling spectral directional quad-averaged water-reflected radiance)
Ld_sample_save_fp  = <filepath>  (save downwelling spectral directional quad-averaged radiance at the sample points)
Lu_sample_save_fp  = <filepath>  (save upwelling spectral directional quad-averaged radiance at the sample points)

Note: Directional outputs are saved as data files which can be converted to text outputs using the filetool.
The sample point outputs, eg. 'Ld_sample', will save data files for each sample point with the depth postfixed onto the supplied file name.

Output Hemisphere Image Specification
-------------------------------------
Images of the hemispherical radiance distribution can be saved
using parameters strings of the following format:

<code>_image_save_fp  = <filepath>  (filepath to save hemisphere PPM image to, optional)
<code>_image_size     = <integer>   (size of hemisphere PPM image in pixels)
<code>_image_sens_k   = <real>      (sensitivity of radinace to RGB conversion, optional)

where <code> is any of:

  Ld_a       downwelling quad-averaged radiance above the water surface
  Lu_a       upwelling quad-averaged radiance above the water surface
  Ld_w       downwelling quad-averaged radiance just below the water surface
  Lu_w       upwelling quad-averaged radiance just below the water surface
  Ld_b       downwelling quad-averaged radiance at the water column bottom
  Lu_b       upwelling quad-averaged radiance at the water column bottom
  Ld_it      downwelling quad-averaged transmitted into water radiance
  Lu_it      upwelling quad-averaged water-leaving radiance
  Ld_ir      downwelling quad-averaged water under side reflected radiance
  Lu_ir      upwelling quad-averaged water top side reflected radiance
  Ld_sample  downwelling quad-averaged radiance at the sample points
  Lu_sample  upwelling quad-averaged radiance at the sample points
Image files a saved as ppm format with a '.ppm' extension appended if it is not already present.
If sample point saves are requested the filenames will have the depth in meters appended before the '.ppm' extension.
The number of digits after the decimal point used to code the depth for the filename
defaults to two but can be set in the parameters by:

depth_code_prec = <integer>
General Options
---------------
verbose     = <integer>  (verbosity level 0-9, default '2')
log_save_fp = <filepath>  (file to save log to, optional)

notes_include_params = yes | no   (include run parameters in notes of saved data files, default yes)
```
## AppImage
Coming soon!

## 🕸 Multithreaded support
PlanarRad now comes with limited multithreaded support for `slabtool` when using the default build script. There is some non-parallel overhead in the multithreaded program, so it is recommended to turn off multi-threading if you are batching large numbers of program runs across across cores/nodes, as then you will have better throughput. For a single-run, keep it on for faster latency.   

To change number of threads, set the environment variable `OMP_NUM_THREADS` at runtime, e.g. for only one run you can use:
```
OMP_NUM_THREADS=1 <PlanarRad command>
```
