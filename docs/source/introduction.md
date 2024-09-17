# Introduction
PlanarRad is free software for modelling light in natural waters or other homegenous scattering and absorbing media. 
It is functionally similar to the commercial software Hydrolight.


PlanarRad does not have:

- Infinite depth water
- Vertical stratification of optical parameters
- Inelastic scattering (chlorophyll or CDOM fluoresence, Raman scattering)
- Any bio-optical models, you must provide IOPs directly rather than chlorophyll concentration. However PlanarRadBatch provides functions for this.

However PlanarRad does have:

- An attractive price point - it's free as in beer
- Open source code licensed under the GPL - it's free as in freedom
- Highly scriptable command-line interface
- Output results in an easily manageable text file
- GUI front-end with interactive visualisations and plots (ideal for educational use)
- Automatic spectral resampling for easy integration of data from multiple instruments
- Ability to load in actual irradiance or radiance profiles for comparison to model outputs - i.e. model closure experiments
- Easy reconfiguration of the directional discretization of radiance - no recompiling required
- Nearly identical results to Hydrolight that can be verified on your own machine - example report (TODO: Add link)
- A user-generated user manual. You are reading it! Please contribute!


## More Information
PlanarRad is a freely available open-source C++ implementation of the invariant imbedded numerical integration 
technique for calculating radiative transfer in plane-parallel media with an opaque bottom boundary. It is based 
on the algorithm described in Curt Mobley's book Light and Water, and was designed for modelling light propagation 
in, and reflection from, shallow water environments. However, by setting a suitably large depth an infinite depth 
solution can be approximated. PlanarRad was originally developed by John Hedley during a period in which he was based at 
the University of Exeter and variously funded by Natural Environment Research Council and the World Bank / GEF Coral 
Reef Targeted Research Project. The [NERC Field Spectroscopy Facility](http://fsf.nerc.ac.uk/) also indirectly supported PlanarRad by funding 
the development of the WLTool software. 

Old versions of PlanarRad can be downloaded here (TODO):
- Linux version 0.9.5
- Windows version 0.9

There are also some other community maintained versions that may be more up to date than v0.9.5 linked above:

- marrabld's fork 
   - marrabld also has a python-GUI and python batch scripts (paralleling across many runs)

## Citing PlanarRad
If you make use of PlanarRad in a publication the most suitable peer-review publication to cite is:

Hedley, J (2008). A three-dimensional radiative transfer model for shallow water environments, Optics Express 16, 21887-21902.

The main topic of that paper is a different radiative transfer model, but PlanarRad was also used and Figure 5 of that paper can be considered a validation of PlanarRad by model intercomparison.

See here for the Full list of publications using PlanarRad. (TODO)

If you publish anything using PlanarRad, we would love to know, please do so by making a post on the github.

## Support and bug reports
PlanarRad is unfunded so my ability to provide support is extremely limited. Nevertheless myself (Leigh) and John Hedley are likely to respond to an 
email/dm/post. If you would like to help PlanarRad survive, please report any bugs you find and/or make feature requests and/or get in touch! 


