# Star Catalogs in JSON Format

## Yale Bright Star Catalog (v5)
This is a perl script to convert the Yale Bright Star Catalog from ASCII format (found at 
http://tdc-www.harvard.edu/catalogs/bsc5.html) to a JSON format.

There are several versions of this file processed for use:

| File | Description | URL |
| ---- | ----------- | --- |
| bsc5.json | Most BSC fields, with RA/Dec values consolidated, Notes consolidated, and computed values for MKK spectral and luminosity classes (including approximate color temperature) | https://brettonw.github.io/YaleBrightStarCatalog/bsc5.json |
| bsc5-orig.json | Original BSC fields as found in bsc5.readme.txt | https://brettonw.github.io/YaleBrightStarCatalog/bsc5-orig.json |
| bsc5-all.json | All original BSC fields as found in bsc5.readme.txt, and all consolidated and computed fields | https://brettonw.github.io/YaleBrightStarCatalog/bsc5-all.json |
| bsc5-short.json | Short version of the BSC with RA/Dec, V, K, and name values (B, F, C, N) | https://brettonw.github.io/YaleBrightStarCatalog/bsc5-short.json |

Fields in the Original BSC5 file (empty fields are omitted):

| Field | Description                                                                                                                          |
| ----- |--------------------------------------------------------------------------------------------------------------------------------------|
| HR | Harvard Revised Number = Bright Star Number                                                                                          |
| Flamsteed| Flamsteed number, to be taken with the constellation name                                                                            | 
| FlamsteedF| Flamsteed designation with full genitive form constellation name                                                                     | 
| Bayer| Bayer designation as greek letter with superscript sequence (if multi), to be taken with the constellation name                      | 
| BayerF| Bayer designation with spelled out greek letter, sequence, and genitive form constellation name                                      | 
| Common | The common name of the star (drawn from IAU designations and notes)                                                                  |
| DM | Durchmusterung Identification                                                                                                        |
| HD | Henry Draper Catalog Number                                                                                                          |
| SAO | SAO Catalog Number                                                                                                                   |
| FK5 | FK5 Star Number                                                                                                                      |
| IRflag | I if infrared source                                                                                                                 |
| r_IRflag | Coded reference for infrared source                                                                                                  |
| Multiple | Double or multiple-star code                                                                                                         |
| ADS | Aitken's Double Star Catalog (ADS) designation                                                                                       |
| ADScomp | ADS number components                                                                                                                |
| VarID | Variable star identification                                                                                                         |
| RAh1900 | Hours RA, equinox B1900, epoch 1900.0                                                                                                |
| RAm1900 | Minutes RA, equinox B1900, epoch 1900.0                                                                                              |
| RAs1900 | Seconds RA, equinox B1900, epoch 1900.0                                                                                              |
| DE-1900 | Sign Dec, equinox B1900, epoch 1900.0                                                                                                |
| DEd1900 | Degrees Dec, equinox B1900, epoch 1900.0                                                                                             |
| DEm1900 | Minutes Dec, equinox B1900, epoch 1900.0                                                                                             |
| DEs1900 | Seconds Dec, equinox B1900, epoch 1900.0                                                                                             |
| RAh | Hours RA, equinox J2000, epoch 2000.0                                                                                                |
| RAm | Minutes RA, equinox J2000, epoch 2000.0                                                                                              |
| RAs | Seconds RA, equinox J2000, epoch 2000.0                                                                                              |
| DE- | Sign Dec, equinox J2000, epoch 2000.0                                                                                                |
| DEd | Degrees Dec, equinox J2000, epoch 2000.0                                                                                             |
| DEm | Minutes Dec, equinox J2000, epoch 2000.0                                                                                             |
| DEs | Seconds Dec, equinox J2000, epoch 2000.0                                                                                             |
| GLON | Galactic longitude                                                                                                                   |
| GLAT | Galactic latitude                                                                                                                    |
| Vmag | Visual magnitude                                                                                                                     |
| n_Vmag | Visual magnitude code                                                                                                                |
| u_Vmag | Uncertainty flag on V                                                                                                                |
| B-V | B-V color in the [UBV system](https://en.wikipedia.org/wiki/UBV_photometric_system)                                                    |
| u_B-V | Uncertainty flag on B-V                                                                                                              |
| U-B | U-B color in the [UBV system](https://en.wikipedia.org/wiki/UBV_photometric_system)                                                  |
| u_U-B | Uncertainty flag on U-B                                                                                                              |
| R-I | R-I   in system specified by n_R-I                                                                                                   |
| n_R-I | Code for R-I system (Cousin, Eggen)                                                                                                  |
| SpType | Spectral type                                                                                                                        |
| n_SpType | Spectral type code                                                                                                                   |
| SpectralCl | The [MKK](https://en.wikipedia.org/wiki/Stellar_classification) spectral class (OBAFGKMSC) with the numerical sub-class (if present) |
| LuminosityCls | The [MKK](https://en.wikipedia.org/wiki/Stellar_classification) luminosity class (I[a,b], II, III, IV, V)                            |
| K | An approximate color temperature of the star, computed from B-V or the SpectralCls                                                   |
| pmRA | Annual proper motion in RA J2000, FK5 system                                                                                         |
| pmDE | Annual proper motion in Dec J2000, FK5 system                                                                                        |
| n_Parallax | D indicates a dynamical parallax, otherwise a trigonometric parallax                                                                 |
| Parallax | Trigonometric parallax                                                                                                               |
| RadVel | Heliocentric Radial Velocity                                                                                                         |
| n_RadVel | Radial velocity comments                                                                                                             |
| l_RotVel | Rotational velocity limit characters                                                                                                 |
| RotVel | Rotational velocity, v sin i                                                                                                         |
| u_RotVel | uncertainty and variability flag on RotVel                                                                                           |
| Dmag | Magnitude difference of double, or brightest multiple                                                                                |
| Sep | Separation of components in Dmag if occultation binary                                                                               |
| MultID | Identifications of components in Dmag                                                                                                |
| MultCnt | Number of components assigned to a multiple                                                                                          |
| Notes | Notes, consolidated, as (Category, Remark)                                                                                           |

Computed Fields (empty fields are omitted):

| Field | Description |
| ----- | ----------- |
| RA1900 | Right Ascension (00h 00m 00.0s), equinox B1900, epoch 1900.0 |
| Dec1900 | Declination (+/-00° 00′ 00″), equinox B1900, epoch 1900.0 |
| RA | Right Ascension (00h 00m 00.0s), equinox J2000, epoch 2000.0 |
| Dec | Declination (+/-00° 00′ 00″), equinox J2000, epoch 2000.0 |
| Flamsteed| Flamsteed number, to be taken with the constellation name | 
| FlamsteedF| Flamsteed designation with full genitive form constellation name | 
| Bayer| Bayer designation as greek letter with superscript sequence (if multi), to be taken with the constellation name | 
| BayerF| Bayer designation with spelled out greek letter, sequence, and genitive form constellation name | 
| Constellation | The traditional 3-letter abbreviation for the constellation name |
| Common | The common name of the star (drawn from IAU designations and notes) |
| SpectralCl | The MKK spectral class (OBAFGKMSC) with the numerical sub-class (if present) |
| LuminosityCls | The MKK luminosity class (Ia,Ib, II, III, IV, V) |
| K | An approximate color temperature of the star, computed from B-V or the SpectralCls |

Fields in the Short BSC5 file (empty fields are omitted):

| Field | Description |
| ----- | ----------- |
| HR | Harvard Revised Number = Bright Star Number |
| F| Flamsteed number, to be taken with the constellation name | 
| B| Bayer designation as greek letter with superscript sequence (if multi), to be taken with the constellation name | 
| N | The common name of the star (drawn from IAU designations and notes) |
| C | The traditional 3-letter abbreviation for the constellation name |
| RA | Right Ascension (00h 00m 00.0s), equinox J2000, epoch 2000.0 |
| Dec | Declination (+/-00° 00′ 00″), equinox J2000, epoch 2000.0 |
| K | An approximate color temperature of the star, computed from B-V or the SpectralCls |
| V | Visual magnitude |

See also:
* Almanac Bright Stars 2016 (https://brettonw.github.io/YaleBrightStarCatalog/almanac-2016.json)

## Messier Catalog 
Fields in the Messier catalog file (https://brettonw.github.io/YaleBrightStarCatalog/messier.json):

| Field | Description |
| ----- | ----------- |
| M | Messier number |
| NGC| New General Catalogue number | 
| N | The common name of the object (if there is one) |
| T | The type of the object |
| C | The traditional 3-letter abbreviation for the constellation name |
| RA | Right Ascension (00h 00.0m), equinox J2000, epoch 2000.0 |
| Dec | Declination (+/-00° 00′), equinox J2000, epoch 2000.0 |
| V | Visual magnitude |
| S | Size in arc-minutes |

Messier T (Type) values are:

| Type | Description |
| ----- | ----------- |
| OC | Open Cluster | 
| GC | Globular Cluster | 
| PN | Planetary Nebula | 
| DN | Diffuse Nebula | 
| AS | Asterism | 
| DS | Double Star | 
| MW | Milky Way | 
| SG | Spiral Galaxy | 
| BG | Barred Galaxy | 
| LG | Lenticular Galaxy | 
| EG | Elliptical Galaxy | 
| IG | Irregular Galaxy | 
| SN | Supernova | 

## ADC Position and Proper Motion (PPM) Catalog
This catalog includes PPM North, PPM South, the Bright Stars Supplement, and an additional 90,000 stars. The catalog is a complete survey of all stars brighter than 7.6 magnitude. 
The source data is in [TDAT format](https://heasarc.gsfc.nasa.gov/docs/software/dbdocs/tdat.html).

Fields in the PPM ()

| Field | Description |
| ----- | ----------- |
| name | Serial Number of Star in PPM |
| dm_number | Designation in DM Catalog |
| vmag | Photographic Magnitude |
| spect_type | Spectral Type |
| ra | Right Ascension |
| dec | Declination |
| lii | Galactic Longitude |
| bii | Galactic Latitude |
| ra_cat | Original Catalog J2000 RA |
| dec_cat | Original Catalog J2000 Dec |
| ra_prop | Proper Motion in RA (sec/yr) |
| dec_prop | Proper Motion in Dec ("/yr) |
| n_pub | Number of Individual Positions |
| ra_mean_err | Mean Error in RA in arcsec |
| dec_mean_err | Mean error in Dec in arcsec |
| pm_ra_mean_err | Mean error in RA PM (mas/yr) |
| pm_dec_mean_err | Mean error in Dec PM (mas/yr) |
| epa | Weighted Mean RA Epoch (Y-1900) |
| epd | Weighted Mean Declination Epoch (Y-1900) |
| sao | SAO Catalog Designation |
| hd | Henry Draper Catalog Designation |
| agk3 | AGK3 Catalog Designation |
| cpd | Cape Photograph DM Designation |
| notes | Notes |
| class | Browse Object Classification |
