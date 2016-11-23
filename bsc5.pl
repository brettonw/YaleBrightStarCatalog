#! /usr/local/bin/perl

# use strict causes compilation errors that would be fixed by the require statement below, but
# require is executed at runtime - I *should* convert common.pl to a module, but that would just
# make more work with no actual gain.
#use strict;
use warnings FATAL => "all";
no warnings "once";
use feature "unicode_strings";
use utf8;
use open ":std", ":encoding(UTF-8)";

# yes, yes - all you perl gurus, this is abuse. I just want to include code I wrote, alright?
require ("common.pl");

# download the bsc5.dat and bsc5.notes files from http://tdc-www.harvard.edu/catalogs/bsc5.html, and
# gunzip them into the "unpacked" directory

# command line or file for the inputs
if (scalar(@ARGV) > 0) {
    foreach my $arg (@ARGV) {
        foreach my $field (split(/,/, $arg)) {
            my $asField = $field;
            if ($field =~ /^([^=]+)=([^=]+)$/) {
                $field = $1;
                $asField = $2;
            }
            $field = chew ($field);
            $asField = chew ($asField);
            $appendJsonAs{$field} = $asField;
            print STDERR "($field) = ($asField)\n"
        }
    }
}

# common variables
my $fh;
my $filename;
my $bayerMatchCount = 0;
my $flamsteedMatchCount = 0;
my $draperMatchCount = 0;

# common names, from the notes...
my %commonNames;

# load the notes file
my %notesById;
my %notesByIdCat;
$filename = "unpacked/bsc5.notes";
open($fh, "<:encoding(UTF-8)", $filename) or die "Could not open file '$filename' $!";
while (my $entry = <$fh>) {
    #chomp $entry;
    #$entry =~ s/(\s)+/$1/g;
    #$entry =~ s/^\s*//g;
    #$entry =~ s/\s*$//g;

    # every line is of the form (/^\s([\s\d]{4})([\s\d]{2})([\s\w:]{4})\s(.*)/)
    if ($entry =~ /^\s([\s\d]{4})([\s\d]{2})([\s\w:]{4})\s(.*)$/) {
        my ($id, $sequence, $category, $remark) = ($1, $2, $3, $4);
        $id =~ s/^\s*//;
        $id =~ s/\s*$//;
        $id =~ s/(\s)+/$1/g;
        $sequence =~ s/^\s*//;
        $sequence =~ s/\s*$//;
        $sequence =~ s/(\s)+/$1/g;
        $category =~ s/://;
        $category =~ s/^\s*//;
        $category =~ s/\s*$//;
        $category =~ s/(\s)+/$1/g;
        $remark =~ s/^\s*//;
        $remark =~ s/\s*$//;
        $remark =~ s/(\s)+/$1/g;
        $remark =~ s/"/\\"/g;
        my $idCat = "$id-$category";
        if ($sequence == 1) {
            $notesByIdCat{$idCat} = $remark;
            if (exists ($notesById{$id})) {
                $notesById{$id} .= ";$idCat";
            } else {
                $notesById{$id} = $idCat;
            }

            # special check for the name...
            if (($category eq "N") && ($remark =~ /^(\w+)[;\.]/)) {
                my $commonName = ucfirst(lc ($1));
                $commonNames{$id} = $commonName;
                print STDERR "Found Name In Notes ($id -> $commonName)\n";
            }
        } else {
            $notesByIdCat{$idCat} .= " $remark";
        }
        print STDERR "Note: ($id-$category)($sequence)($remark)\n";
    }
}
close $fh;

# all the fields (from the "read me")
#  0    1-  4  I4     ---     HR         [1/9110]+ Harvard Revised Number = Bright Star Number
#  1    5- 14  A10    ---     Name       Name, generally Bayer and/or Flamsteed name
#  2   15- 25  A11    ---     DM         Durchmusterung Identification (zone in bytes 17-19)
#  3   26- 31  I6     ---     HD         [1/225300]? Henry Draper Catalog Number
#  4   32- 37  I6     ---     SAO        [1/258997]? SAO Catalog Number
#  5   38- 41  I4     ---     FK5        ? FK5 star Number
#  6       42  A1     ---     IRflag     [I] I if infrared source
#  7       43  A1     ---     r_IRflag   *[ ':] Coded reference for infrared source
#  8       44  A1     ---     Multiple   *[AWDIRS] Double or multiple-star code
#  9   45- 49  A5     ---     ADS        Aitken's Double Star Catalog (ADS) designation
# 10   50- 51  A2     ---     ADScomp    ADS number components
# 11   52- 60  A9     ---     VarID      Variable star identification
# 12   61- 62  I2     h       RAh1900    ?Hours RA, equinox B1900, epoch 1900.0 (1)
# 13   63- 64  I2     min     RAm1900    ?Minutes RA, equinox B1900, epoch 1900.0 (1)
# 14   65- 68  F4.1   s       RAs1900    ?Seconds RA, equinox B1900, epoch 1900.0 (1)
# 15       69  A1     ---     DE-1900    ?Sign Dec, equinox B1900, epoch 1900.0 (1)
# 16   70- 71  I2     deg     DEd1900    ?Degrees Dec, equinox B1900, epoch 1900.0 (1)
# 17   72- 73  I2     arcmin  DEm1900    ?Minutes Dec, equinox B1900, epoch 1900.0 (1)
# 18   74- 75  I2     arcsec  DEs1900    ?Seconds Dec, equinox B1900, epoch 1900.0 (1)
# 19   76- 77  I2     h       RAh        ?Hours RA, equinox J2000, epoch 2000.0 (1)
# 20   78- 79  I2     min     RAm        ?Minutes RA, equinox J2000, epoch 2000.0 (1)
# 21   80- 83  F4.1   s       RAs        ?Seconds RA, equinox J2000, epoch 2000.0 (1)
# 22       84  A1     ---     DE-        ?Sign Dec, equinox J2000, epoch 2000.0 (1)
# 23   85- 86  I2     deg     DEd        ?Degrees Dec, equinox J2000, epoch 2000.0 (1)
# 24   87- 88  I2     arcmin  DEm        ?Minutes Dec, equinox J2000, epoch 2000.0 (1)
# 25   89- 90  I2     arcsec  DEs        ?Seconds Dec, equinox J2000, epoch 2000.0 (1)
# 26   91- 96  F6.2   deg     GLON       ?Galactic longitude (1)
# 27   97-102  F6.2   deg     GLAT       ?Galactic latitude (1)
# 28  103-107  F5.2   mag     Vmag       ?Visual magnitude (1)
# 29      108  A1     ---     n_Vmag     *[ HR] Visual magnitude code
# 30      109  A1     ---     u_Vmag     [ :?] Uncertainty flag on V
# 31  110-114  F5.2   mag     B-V        ? B-V color in the UBV system
# 32      115  A1     ---     u_B-V      [ :?] Uncertainty flag on B-V
# 33  116-120  F5.2   mag     U-B        ? U-B color in the UBV system
# 34      121  A1     ---     u_U-B      [ :?] Uncertainty flag on U-B
# 35  122-126  F5.2   mag     R-I        ? R-I   in system specified by n_R-I
# 36      127  A1     ---     n_R-I      [CE:?D] Code for R-I system (Cousin, Eggen)
# 37  128-147  A20    ---     SpType     Spectral type
# 38      148  A1     ---     n_SpType   [evt] Spectral type code
# 39  149-154  F6.3 arcsec/yr pmRA       *?Annual proper motion in RA J2000, FK5 system
# 40  155-160  F6.3 arcsec/yr pmDE       ?Annual proper motion in Dec J2000, FK5 system
# 41      161  A1     ---     n_Parallax [D] D indicates a dynamical parallax, otherwise a trigonometric parallax
# 42  162-166  F5.3   arcsec  Parallax   ? Trigonometric parallax (unless n_Parallax)
# 43  167-170  I4     km/s    RadVel     ? Heliocentric Radial Velocity
# 44  171-174  A4     ---     n_RadVel   *[V?SB123O ] Radial velocity comments
# 45  175-176  A2     ---     l_RotVel   [<=> ] Rotational velocity limit characters
# 46  177-179  I3     km/s    RotVel     ? Rotational velocity, v sin i
# 47      180  A1     ---     u_RotVel   [ :v] uncertainty and variability flag on RotVel
# 48  181-184  F4.1   mag     Dmag       ? Magnitude difference of double, or brightest multiple
# 49  185-190  F6.1   arcsec  Sep        ? Separation of components in Dmag if occultation binary.
# 50  191-194  A4     ---     MultID     Identifications of components in Dmag
# 51  195-196  I2     ---     MultCnt    ? Number of components assigned to a multiple
# 52      197  A1     ---     NoteFlag   [*] a star indicates that there is a note (see file notes)

my @fieldNames = (
    "HR", "Name", "DM", "HD", "SAO", "FK5", "IRflag", "r_IRflag", "Multiple", "ADS", "ADScomp",
    "VarID", "RAh1900", "RAm1900", "RAs1900", "DE-1900", "DEd1900", "DEm1900", "DEs1900", "RAh",
    "RAm", "RAs", "DE-", "DEd", "DEm", "DEs", "GLON", "GLAT", "Vmag", "n_Vmag", "u_Vmag", "B-V",
    "u_B-V", "U-B", "u_U-B", "R-I", "n_R-I", "SpType", "n_SpType", "pmRA", "pmDE", "n_Parallax",
    "Parallax", "RadVel", "n_RadVel", "l_RotVel", "RotVel", "u_RotVel", "Dmag", "Sep", "MultID",
    "MultCnt", "NoteFlag"
);
my %fieldIndexes;

for (my $i = 0; $i < scalar (@fieldNames); $i++) {
    $fieldIndexes{$fieldNames[$i]} = $i;
}

sub getFieldByIndex {
    my ($fieldsHashRef, $fieldIndex) = @_;
    my $fieldName = $fieldNames[$fieldIndex];
    return exists ($fieldsHashRef->{$fieldName}) ? $fieldsHashRef->{$fieldName} : "";
}

my @fieldPositions = (
    1, 5, 15, 26, 32, 38, 42, 43, 44, 45, 50, 52, 61, 63, 65, 69, 70, 72, 74, 76, 78, 80, 84, 85,
    87, 89, 91, 97, 103, 108, 109, 110, 115, 116, 121, 122, 127, 128, 148, 149, 155, 161, 162, 167,
    171, 175, 177, 180, 181, 185, 191, 195, 197, 198
);

my %categoryNames = (
    "C" => "Colors", "D" => "Double and multiple stars", "DYN" => "Dynamical parallaxes",
    "G" => "Group membership", "M" => "Miscellaneous", "N" => "Star names", "P" => "Polarization",
    "R" => "Stellar radii or diameters", "RV" => "Radial and/or rotational velocities",
    "S" => "Spectra", "SB" => "Spectroscopic binaries", "VAR" => "Variability"
);

#open the JSON array
print "[\n";
my $lineCount = 0;

# open the catalog file and traverse the rows
$filename = "unpacked/bsc5.dat";
open($fh, "<:encoding(UTF-8)", $filename) or die "Could not open file '$filename' $!";
while (my $entry = <$fh>) {
    # pad the entry line, as the original is truncated if not all the fields are present
    $entry =~ s/\n//;
    $entry = sprintf ("%-200s", $entry);
    print STDERR "\nENTRY) $entry\n";

    # get the fields
    my %fieldsHash;
    my $fieldsHashRef = \%fieldsHash;
    for (my $i = 0; $i < scalar (@fieldNames); $i++) {
        my $fieldIndex = $fieldPositions[$i] - 1;
        my $fieldLength = ($fieldPositions[$i + 1] - 1) - $fieldIndex;
        my $fieldValue = chew (substr ($entry, $fieldIndex, $fieldLength));
        if (length ($fieldValue) > 0) {
            my $fieldName = $fieldNames[$i];
            $fieldsHash{$fieldName} = $fieldValue;
            print STDERR "($fieldName) = ($fieldValue)\n";
        }
    }

    # figure the id
    my $id = $fieldsHash{"HR"};

    # skip this line if it is largely empty
    if (!exists ($fieldsHash{"HD"})) {
        print STDERR "Skipping empty line $id\n";
    } else {
        # make sure the JSON output is printed correctly between lines
        if ($lineCount != 0) {
            print ",\n";
        }
        $lineCount++;

        # set the common name if we already know it, but we will prefer the IAU name if we've got that
        if (exists ($commonNames{$id})) {
            $fieldsHash{"Common"} = $commonNames{$id};
            print STDERR "Common name found in notes ($fieldsHash{'Common'})\n";
        }

        # try the HD catalog number
        my $hdn = "HD-".$fieldsHash{"HD"};
        print STDERR "Trying Draper designation: $hdn\n";
        if (exists ($starNames{$hdn})) {
            $fieldsHash{"Common"} = $starNames{$hdn};
            print STDERR "Matched Draper (HD) designation: $hdn ($fieldsHash{'Common'})\n";
            $draperMatchCount++;
        }

        my $name = getFieldByIndex($fieldsHashRef, 1);
        if (length ($name) > 0)
        {
            print STDERR ("name ($name)\n");
            # try to get the common name, have to condition the name a bit - it might be a shortened version
            # of a bayer name (Alp Cen) or a flamsteed name (13 Tau), with a few special cases

            #print STDERR ("name ($name)\n");
            # "74Psi1Psc", "33    Psc", "       ", "11Bet Cas"
            if ($name =~ /([^\d\s]+)$/) {
                my $constellationName = $1;
                #print STDERR "Constellation Name ($constellationName)\n";
                $name =~ s/\s*[^\d\s]+$//;

                # try to find the star name using the flamsteed number
                #print STDERR ("name ($name)\n");
                if ($name =~ /^(\d+)/) {
                    my $flamsteedNumber = $1;
                    $name =~ s/^\d+\s*//;

                    # try to find the star name from the flamsteed number
                    my $fn = "$flamsteedNumber $constellationNames{$constellationName}";
                    $fieldsHash{"FlamsteedA"} = $fn;
                    $fieldsHash{"FlamsteedF"} = makeFullName($fn);
                    print STDERR "Trying Flamsteed designation: $fn\n";
                    if (exists ($starNames{$fn})) {
                        $fieldsHash{"Common"} = $starNames{$fn};
                        print STDERR "Matched Flamsteed designation: $fn ($fieldsHash{'Common'})\n";
                        $flamsteedMatchCount++;
                    }
                }

                # now try to find the star name using the bayer number
                #print STDERR ("name ($name)\n");
                if ($name =~ /^([^\d\s]+)/) {
                    my $bayerNumber = $1;
                    #print STDERR ("bayerNumber ($bayerNumber)\n");
                    $name =~ s/^[^\d\s]+\s*//;
                    #print STDERR ("name ($name)\n");

                    my $sequence = ($name =~ /^(\d)/) ? ($superscripts[$1 - 1]) : "";

                    # try to find the star name from the bayer number
                    my $bn = "$greekNames{$bayerNumber}$sequence $constellationNames{$constellationName}";
                    $fieldsHash{"BayerA"} = $bn;
                    $fieldsHash{"BayerF"} = makeFullName ($bn);
                    print STDERR "Trying Bayer designation: $bn\n";
                    if (exists ($starNames{$bn})) {
                        $fieldsHash{"Common"} = $starNames{$bn};
                        print STDERR "Matched Bayer designation: $bn ($fieldsHash{'Common'})\n";
                        $bayerMatchCount++;
                    }
                }
            }
        }

        # add the RA/Dec consolidated fields
        $fieldsHash{"RA1900"} = getFieldByIndex($fieldsHashRef, 12)."h ".getFieldByIndex($fieldsHashRef, 13)."m ".getFieldByIndex($fieldsHashRef, 14)."s";
        $fieldsHash{"Dec1900"} = getFieldByIndex($fieldsHashRef, 15).getFieldByIndex($fieldsHashRef, 16)."° ".getFieldByIndex($fieldsHashRef, 17)."′ ".getFieldByIndex($fieldsHashRef, 18)."″";
        $fieldsHash{"RA"} = getFieldByIndex($fieldsHashRef, 19)."h ".getFieldByIndex($fieldsHashRef, 20)."m ".getFieldByIndex($fieldsHashRef, 21)."s";
        $fieldsHash{"Dec"} = getFieldByIndex($fieldsHashRef, 22).getFieldByIndex($fieldsHashRef, 23)."° ".getFieldByIndex($fieldsHashRef, 24)."′ ".getFieldByIndex($fieldsHashRef, 25)."″";

        # condition the spectral type field as: type (only one), luminosity class (only one), and
        # exceptions
        my $spType = $fieldsHash{"SpType"};
        if ($spType =~ s/^[a-z]*([OBAFGKMSC])//) {
            my $spectralClass = $1;

            # try to read the sub class, if one is present
            if ($spType =~ s/(\d([-\.]\d)?)//) {
                $spectralClass .= $1;
            }
            print STDERR "Spectral Class ($spectralClass) [$fieldsHash{'SpType'}]\n";
            $fieldsHash{"SpectralCls"} = $spectralClass;

            # try to read the luminosity class
            if ($spType =~ s/((I[ab]+)|(I[IV]*)|V)//) {
                my $luminosityClass = $1;
                print STDERR "Luminosity Class ($luminosityClass) [$fieldsHash{'SpType'}]\n";
                $fieldsHash{"LuminosityCls"} = $luminosityClass;
            } else {
                print STDERR "UNABLE TO READ LUMINOSITY CLASS ($fieldsHash{'SpType'})\n";
            }
        } else {
            print STDERR "UNABLE TO READ SPECTRAL CLASS ($fieldsHash{'SpType'})\n";
        }

        # add notes, if any
        if (exists ($fieldsHash{"NoteFlag"}) && ($fieldsHash{"NoteFlag"} eq "*") && exists ($notesById{$id})) {
            # split the notes entry into an array, referring to the idCats
            my @notesForIdByCat = split (/;/, $notesById{$id});
            my $noteArray = "[ ";
            for (my $i = 0; $i < scalar (@notesForIdByCat); $i++) {
                if ($i > 0) {
                    $noteArray .= ", ";
                }
                my $idCat = $notesForIdByCat[$i];
                my $category;
                if ($idCat =~ /^\d+-(\w+)$/) {
                    $category = $categoryNames{$1};
                }
                my $remark = $notesByIdCat{$idCat};
                $noteArray .= "{ ";
                $noteArray .= appendJson ("Category", $category, 0);
                $noteArray .= appendJson ("Remark", $remark, 1);
                $noteArray .= " }";
                print STDERR "Note ($category) ($remark)\n";
            }
            $noteArray .= " ]";

            # output the tag element
            $fieldsHash{"Notes"} = $noteArray;
        }

        # construct the JSON record for the line
        # close the line and output it
        my @fieldKeys = sort (keys (%fieldsHash));
        my $comma = 0;
        $entry = "{ ";
        foreach my $fieldKey (@fieldKeys) {
            my $json = appendJson ($fieldKey, $fieldsHash{$fieldKey}, $comma);
            if (length ($json) > 0) {
                $entry .= $json;
                $comma = 1;
            }
        }
        $entry .= " }";
        print "$entry";
    }
}

print "\n]";
close $fh;

print STDERR "\nSUMMARY\n";
print STDERR "Matched $flamsteedMatchCount Flamsteed designations\n";
print STDERR "Matched $bayerMatchCount Bayer designations\n";
print STDERR "Matched $draperMatchCount Draper designations\n";
print STDERR "Matched Total (".($flamsteedMatchCount + $bayerMatchCount + $draperMatchCount).") designations\n";
