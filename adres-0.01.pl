#!/usr/bin/env perl
#
# Gennep
# Vennep
# Keppel
# Soeren
# Smirk
#
# Gonsp aan de Donkel
# Put aan de A

use strict;
use POSIX qw(floor);

my @CITY_PREFIXES = qw(
    Aa Blerker Borrel Eider Flens
    Glutter Kerk Kluitje Kunder Negen Nijen
    Scharrel Snark Water Woud Zeven
);

my @CITY_SUFFIXES = qw(
    beek burg dam dijk dorp drecht heim holt horn hoven
    huizen kamp kerk kerke land oord rade rijk rode stad
    veen voort wijk woude zicht
);

my @CITY_EMBELLISHMENTS = qw(Noord Zuid Oost West Oud Nieuw Hoog Laag);

my @STREET_PREFIXES = qw(
    Appelboom Beekdal Bloesem Dauwdruppel
    Dauw Dijkzicht Duinroos Hooiberg
    Klaver Klompen Korenbloem Molenaars
    Molen Nachtegaal Plataan Rietveld
    Vlinder Vuurvlieg Zonnegloeds Zonnewende
    Merel Kievit Havik Nachtegaal Kwartel
    Hortensia Forsythia
);

my @STREET_SUFFIXES = qw(
    allee gas gracht hof laan pad
    park plein steeg straat weg
);

my @HOUSENUMBER_SUFFIXES = qw(-hs -I -II -III bis A B C D); # ZW RD

############################################################################
# functies
#
sub pick {
    my @set = @_;
    return $set[floor(rand() * $#set)]
}

sub street {
    return pick(@STREET_PREFIXES) . pick(@STREET_SUFFIXES);
}

sub housenumber {
    my $number = floor(2 * exp rand 5);
    my $suffix = (rand > .9) ? pick(@HOUSENUMBER_SUFFIXES) : '';
    return $number . $suffix;
}

sub postcode {
    return floor(rand(9000) + 1000) . " " . chr(65 + rand 26) . chr(65 + rand 26);
}

sub plaats {
    if (rand > .15) {
        return pick(@CITY_PREFIXES) . pick(@CITY_SUFFIXES);
    } elsif (rand > .5) {
        return pick(@CITY_PREFIXES) . pick(@CITY_SUFFIXES) . '-' . pick(@CITY_EMBELLISHMENTS);
    } else {
        return pick(@CITY_EMBELLISHMENTS) . '-' . pick(@CITY_PREFIXES) . pick(@CITY_SUFFIXES);
    }
}

############################################################################

print street, " ", housenumber, "\n";
print postcode, " ", plaats, "\n";




