#!/usr/bin/env perl
#
# Gennep
# Vennep
# Keppel
# Soeren
#
# Gonsp aan de Donkel
# Put aan de A

use strict;
use POSIX qw(floor);

my @CITY_UNIFIXES = qw(Barf Burp Drummel Gonsp Hark Jurk Kimmel Korst Nisk Pik Put Rinsp Smirk);

my @CITY_PREFIXES = qw(
    Aa Aalbesser Acht Achter Beek Blasper Blerker Blinkers Boeren Borrel Casper
    Couwen Daver Duin Eem Eider Even Flens Gaffel Grebben Groenen Grooten Gruns
    Jilser Heer Heien Hoogen Kaal Kemper Kerk Klammer Kluitje Konkel Kunder Loos
    Loden Maagden Middel Negen Nijen Over Ouden Poppel Prakke Riet Rood Scharrel
    Schel Scherpen Schoon Tonnen Uiter Valken Voren Water Willems Woud IJ Zeven
    Zijder Zonkel
    Sint-Michiels Sint-Andreas Sint-Anna
);

my @CITY_SUFFIXES = qw(
    beek berg broek burg dam dijk dorp drecht heim hoef hoek holt
    horn hoven huizen kamp kerk kerke land loo oord rade rijk rode sloot
    sluis stad veen veld vliet voort wijk woude zand zeel zicht zijde zijl
);

my @CITY_EMBELLISHMENTS = qw(Noord Zuid Oost West Oud Nieuw Hoog Laag Groot Klein);

my @RIVERS = qw(A Donkel Kreek Loens);

my @STREET_PREFIXES = (
    qw(Molen Kerk Stations Klooster Hoofd Ring),
    qw(Klompen Molenaars Wijngaard),
    qw(Ruiter),
    qw(Duin Beekdal Dijkzicht Moeras Vallei),
    qw(Vlas Riet),
    qw(Hooiberg Gaffel Ploeg Fuik),
    qw(Rietveld Beethoven Mozart Mahler Spinoza Sweelinck Mondriaan Liszt),
    qw(Beatrix Bernhard Juliana),
    qw(Tollens Newton Einstein Planck),
    qw(Ouverture Symfonie Aria Concert Viool Harp),
    qw(Ossen),
    qw(Vlinder Vuurvlieg Libelle Egel),
    qw(Sumatra Java Celebes Suriname Curaçao),
    qw(Dauw Dauwdruppel Zonnegloeds Zonnewende),
    qw(Agaat Saffier Jade Emerald Onyx),
    qw(Merel Kievit Havik Nachtegaal Kwartel Zwaluw Valken Reiger),
    qw(Bloesem Klaver Korenbloem Hortensia Forsythia Distel Braam),
    qw(Plataan Berken Beuken Eiken Wilgen Hazelaar Dennen Iepen Elzen),
);

my @STREET_SUFFIXES = qw(
    allee dreef gas gracht haven hof kade kant laan pad
    park plaats plein singel steeg straat weg
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




