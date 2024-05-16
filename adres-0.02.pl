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
    Aa Acht Achter Beek Blerker Boeren Borrel Eem Eider Flens
    Groenen Heer Kerk Kluitje Kunder Middel Negen Nijen Rood
    Scharrel Schel Scherpen Valken Voren Water Willems Woud Zeven
    Sint-Michiels Sint-Andreas Sint-Anna
);

my @CITY_SUFFIXES = qw(
    beek broek burg dam dijk dorp drecht heim hoek holt
    horn hoven huizen kamp kerk kerke land oord rade rijk
    rode stad veen voort wijk woude zand zicht
);

my @CITY_EMBELLISHMENTS = qw(Noord Zuid Oost West Oud Nieuw Hoog Laag Groot Klein);

my @STREET_PREFIXES = qw(
    Duin Beekdal Dijkzicht Moeras Vallei
    Hooiberg Gaffel Ploeg
    Klompen Molenaars Molen Kerk Stations Wijngaard Klooster
    Rietveld Beethoven Mozart Spinoza Sweelinck Mondriaan
    Vlinder Vuurvlieg Libelle Egel
    Dauw Dauwdruppel Zonnegloeds Zonnewende
    Merel Kievit Havik Nachtegaal Kwartel Zwaluw
    Bloesem Klaver Korenbloem Hortensia Forsythia Distel Braam
    Plataan Berken Beuken Eiken Wilgen Hazelaar Dennen
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




