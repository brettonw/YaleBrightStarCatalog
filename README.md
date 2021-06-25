# Yale Bright Star Catalog (v5) in JSON Format
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

| Field | Description |
| ----- | ----------- |
| HR | Harvard Revised Number = Bright Star Number |
| Flamsteed| Flamsteed number, to be taken with the constellation name | 
| FlamsteedF| Flamsteed designation with full genitive form constellation name | 
| Bayer| Bayer designation as greek letter with superscript sequence (if multi), to be taken with the constellation name | 
| BayerF| Bayer designation with spelled out greek letter, sequence, and genitive form constellation name | 
| Common | The common name of the star (drawn from IAU designations and notes) |
| DM | Durchmusterung Identification |
| HD | Henry Draper Catalog Number |
| SAO | SAO Catalog Number |
| FK5 | FK5 Star Number |
| IRflag | I if infrared source |
| r_IRflag | Coded reference for infrared source |
| Multiple | Double or multiple-star code |
| ADS | Aitken's Double Star Catalog (ADS) designation |
| ADScomp | ADS number components |
| VarID | Variable star identification |
| RAh1900 | Hours RA, equinox B1900, epoch 1900.0 |
| RAm1900 | Minutes RA, equinox B1900, epoch 1900.0 |
| RAs1900 | Seconds RA, equinox B1900, epoch 1900.0 |
| DE-1900 | Sign Dec, equinox B1900, epoch 1900.0 |
| DEd1900 | Degrees Dec, equinox B1900, epoch 1900.0 |
| DEm1900 | Minutes Dec, equinox B1900, epoch 1900.0 |
| DEs1900 | Seconds Dec, equinox B1900, epoch 1900.0 |
| RAh | Hours RA, equinox J2000, epoch 2000.0 |
| RAm | Minutes RA, equinox J2000, epoch 2000.0 |
| RAs | Seconds RA, equinox J2000, epoch 2000.0 |
| DE- | Sign Dec, equinox J2000, epoch 2000.0 |
| DEd | Degrees Dec, equinox J2000, epoch 2000.0 |
| DEm | Minutes Dec, equinox J2000, epoch 2000.0 |
| DEs | Seconds Dec, equinox J2000, epoch 2000.0 |
| GLON | Galactic longitude |
| GLAT | Galactic latitude |
| Vmag | Visual magnitude |
| n_Vmag | Visual magnitude code |
| u_Vmag | Uncertainty flag on V |
| B-V | B-V color in the UBV system |
| u_B-V | Uncertainty flag on B-V |
| U-B | U-B color in the UBV system |
| u_U-B | Uncertainty flag on U-B |
| R-I | R-I   in system specified by n_R-I |
| n_R-I | Code for R-I system (Cousin, Eggen) |
| SpType | Spectral type |
| n_SpType | Spectral type code |
| SpectralCl | The MKK spectral class (OBAFGKMSC) with the numerical sub-class (if present) |
| LuminosityCls | The MKK luminosity class (I[a,b], II, III, IV, V) |
| K | An approximate color temperature of the star, computed from B-V or the SpectralCls |
| pmRA | Annual proper motion in RA J2000, FK5 system |
| pmDE | Annual proper motion in Dec J2000, FK5 system |
| n_Parallax | D indicates a dynamical parallax, otherwise a trigonometric parallax |
| Parallax | Trigonometric parallax |
| RadVel | Heliocentric Radial Velocity |
| n_RadVel | Radial velocity comments |
| l_RotVel | Rotational velocity limit characters |
| RotVel | Rotational velocity, v sin i |
| u_RotVel | uncertainty and variability flag on RotVel |
| Dmag | Magnitude difference of double, or brightest multiple |
| Sep | Separation of components in Dmag if occultation binary |
| MultID | Identifications of components in Dmag |
| MultCnt | Number of components assigned to a multiple |
| Notes | Notes, consolidated, as (Category, Remark)  |

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

Fields in the Messier catalog file (https://brettonw.github.io/YaleBrightStarCatalog/messier.json):

| Field | Description |
| ----- | ----------- |
| M | Messier Number |
| NGC| NGC Number | 
| N | The common name of the object (if there is one) |
| T | The type of the object |
| C | The traditional 3-letter abbreviation for the constellation name |
| RA | Right Ascension (00h 00.0m), equinox J2000, epoch 2000.0 |
| Dec | Declination (+/-00° 00′), equinox J2000, epoch 2000.0 |
| V | Visual magnitude |
| S | Size in arc-minutes |
