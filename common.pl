#! /usr/local/bin/perl

use strict;
use warnings FATAL => 'all';
use feature 'unicode_strings';
use utf8;
use open ':std', ':encoding(UTF-8)';

# greek letter names, with 3 letter abbreviations
our %greekNames;
our %greekFullNames;
sub loadGreekNames {
    my ($filename) = @_;
    my $fh;
    open($fh, "<:encoding(UTF-8)", $filename) or die "Could not open file '$filename' $!";
    while (my $entry = <$fh>) {
        chomp $entry;
        my ($letter,$fullName) = split (/,/, $entry);
        my $abbreviation = substr($fullName, 0,3);
        print STDERR "Read ($letter) as ($fullName), abbreviated as ($abbreviation)\n";
        $greekNames{$abbreviation} = $letter;
        $greekFullNames{$letter} = $fullName;
    }
    close $fh;
}
loadGreekNames ("greekNames.txt");

# constellation names, from http://www.skyviewcafe.com/bayer_flamsteed.html
our %constellationNames;
our %constellationFullNames;
sub loadConstellationNames {
    my ($filename) = @_;
    my $fh;
    open($fh, "<:encoding(UTF-8)", $filename) or die "Could not open file '$filename' $!";
    while (my $entry = <$fh>) {
        chomp $entry;
        my ($abbreviation, $constellationName, $genitiveName) = split (/,/, $entry);
        $constellationNames{$abbreviation} = $abbreviation;
        $constellationNames{$constellationName} = $abbreviation;
        $constellationNames{$genitiveName} = $abbreviation;
        $constellationFullNames{$abbreviation} = $genitiveName;
    }
    close $fh;
}
loadConstellationNames ("constellationNames.txt");

sub makeFullName {
    my ($name) = @_;
    if ($name =~ /^(\d+)\s(\w+)$/) {
        # it's a Flamsteed designation
        return "$1 " . $constellationFullNames{$2};
    }

    if ($name =~ /^(.)([¹²³]?)\s(\w+)/){
        #it's a Bayer designation
        return $greekFullNames{$1} . $2 . " " . $constellationFullNames{$3};
    }

    return "";
}

# IAU star names, need some conditioning on load, from https://en.wikipedia.org/wiki/List_of_proper_names_of_stars
# this file contains either Bayer Designation or Flamsteed designation, but not both like other
# files do, so each line can be cleanly handled
our @superscripts = ('¹', '²', '³', '⁴', '⁵', '⁶', '⁷', '⁸', '⁹');
our %superscriptOrdinals = ( "¹" => 0, "²" => 1, "³" => 2, "⁴" => 3, "⁵" => 4, "⁶" => 5, "⁷" => 6, "⁸" => 7, "⁹" => 8 );
our %starNames;
sub loadStarNames {
    my ($filename) = @_;
    my $fh;
    open($fh, "<:encoding(UTF-8)", $filename) or die "Could not open file '$filename' $!";
    while (my $entry = <$fh>) {
        chomp $entry;
        my ($name, $bayerFlamsteed) = split (/,/, $entry);

        # normalize the bayer designation
        if ($bayerFlamsteed =~ /^([^\s]+)\s*(.*)$/) {
            my ($bf, $constellationName) = ($1, $2);

            if ($bf eq "HD") {
                $starNames{"$bf-$constellationName"} = $name;
                print STDERR "Good star name ('$bf-$constellationName' -> $name)\n";
            } else {

                # determine the sequence (which star of a multiple this is)
                my $sequence = "";
                if ($constellationName =~ s/\s(\w)\w?$//) {
                    my $sequenceNum = ord ($1) - ord ("A");
                    $sequence = $superscripts[$sequenceNum];
                }
                if ($bf =~ s/([^\d]+)(\d)$/$1/) {
                    $sequence = $superscripts[$2 - 1];
                }
                if ($bf =~ s/([¹²³⁴⁵⁶⁷⁸⁹])$//) {
                    #print STDERR "Got... ($1)\n";
                    my $sequenceNum = $superscriptOrdinals{$1};
                    #print STDERR "superscriptOrdinals('¹')... ($superscriptOrdinals{'¹'})\n";
                    #print STDERR "Value... ($sequenceNum)\n";
                    $sequence = $superscripts[$sequenceNum];
                }

                if (exists ($constellationNames{$constellationName})) {
                    $bayerFlamsteed = "$bf$sequence $constellationNames{$constellationName}";
                    if (exists ($starNames{$bayerFlamsteed})) {
                        print STDERR "Duplicate star name ('$bayerFlamsteed' -> $name -> $starNames{$bayerFlamsteed})\n";
                    } else {
                        print STDERR "Good star name ('$bayerFlamsteed' -> $name)\n";
                        $starNames{$bayerFlamsteed} = $name;
                    }
                } else {
                    print STDERR "Unknown constellation: $entry\n";
                }
            }
        } else {
            print STDERR "Bad Bayer Name: $entry\n";
        }
    }
    close $fh;
}
loadStarNames ("starNames-IAU.txt");

# like chomp, only chomp doesn't seem to be working as I expect
sub chew {
    my($value) = @_;
    chomp $value;
    $value =~ s/^\s+//;
    $value =~ s/\s+$//;
    $value =~ s/(\s)+/$1/g;
    return $value;
}

# utility function to make JSON formatting a bit easier. Perl doesn't really do hashes in a way
# that makes passing them around as parameters easily (the syntax is cumbersome), so I've never
# really bothered to get a complete JSON formatting codebase together. this is just a crutch.
our %appendJsonAs;
sub appendJson {
    my($key, $value, $comma) = @_;
    $key = chew ($key);
    $key = (scalar (keys (%appendJsonAs)) == 0) ? $key : $appendJsonAs{$key};
    if (defined ($key)) {
        $value = chew ($value);
        return (length ($value) > 0) ? ((($comma > 0) ? ", " : "" )."\"$key\": \"$value\"") : "";
    }
    return "";
}

# return 1 since this file is included in other files
1;
