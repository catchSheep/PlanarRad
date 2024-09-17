# General scattering and absorbing media
IN PROGRESS


PlanarRad was designed for use with data corresponding to natural water bodies, however it can be used to model the
light field or reflectance properties of homegenous 'slabs' of any kind of media, as long as the following inputs are
known at the wavelength to be modelled:

- The extinction coefficient (a.k.a. the attenuation coefficient, c, they are the same thing).
- The absorption coefficient, a.
- The phase function, i.e. the angular probability of scattering when it occurs.
- The refractive index inside and outside the media.

These concepts may be expressed in other ways that contain the required information. For example if you have a volume
scattering function (VSF) and single scattering albedo, you can then calculate c, a and the phase function. Depending on
the material you might be able to assume an isotropic phase function - that at each scattering event the direction of
scattering is equally probable in any direction over the sphere, and that simplifies things.

Note the following two caveats:

1. The examples below assume that the interface of the slab, what we might call the air-media interface (assuming what
is above the media is air) is completely flat. If it isn't the interface transmission and reflectance function needs to
be modified and unfortunatly PlanarRad currently only has methods for doing that that are appropriate for wind-blown
water surfaces. If you need additional functionality here then it is worth contacting me.

2. PlanarRad does not have functionality for slabs of infinite depth or thickness. You have to specify a thickness and a
reflectance function of whatever is below the slab. However normally this can be solved by setting a sufficiently deep
slab that the bottom infleunce is negligible. Checking his can be done by setting the bottom reflectance to zero, and
then re-running with a higher bottom reflectance, and veirifying the effect on the output is negligible.

## Worked examples

- [BRDF of a material with isotropic phase function](BRDF_isotropic.md)

- [Creating a BRDF file and using it as a bottom boundary](creating_BRDF_bottom_boundary.md)