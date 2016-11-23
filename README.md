# Yale Bright Star Catalog (v5) in JSON Format
This is a perl script to convert the Yale Bright Star Catalog from ASCII format (found at 
http://tdc-www.harvard.edu/catalogs/bsc5.html) to a JSON format.

The Full JSON file is available at: https://brettonw.github.io/YaleBrightStarCatalog/bsc5.json

Fields in the Full JSON file (empty fields are omitted):

| Field | Description |
| ----- | ----------- |
| HR | Harvard Revised Number = Bright Star Number |
| FlamsteedA| Flamsteed designation with 3-letter abbreviated constellation name | 
| FlamsteedF| Flamsteed designation with full genitive form constellation name | 
| BayerA| Bayer designation with greek letter order and 3-letter abbreviated constellation name | 
| BayerF| Bayer designation with spelled out greek letter order and genitive form constellation name | 
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
| RA1900 | Right Ascension (00h 00m 00.0s), equinox B1900, epoch 1900.0 |
| Dec1900 | Declination (+/-00° 00′ 00″), equinox B1900, epoch 1900.0 |
| RA | Right Ascension (00h 00m 00.0s), equinox J2000, epoch 2000.0 |
| Dec | Declination (+/-00° 00′ 00″), equinox J2000, epoch 2000.0 |
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

Note: I've taken the liberty of consolidating the RA and Dec fields, and using Unicode for the Greek letters in Bayer abbreviated designations.

There are several other files available, including:
* A short form of BSC5 (https://brettonw.github.io/YaleBrightStarCatalog/bsc5-short.json)
* Almanac Bright Stars 2016 (https://brettonw.github.io/YaleBrightStarCatalog/almanac-2016.json)
