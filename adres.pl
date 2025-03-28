#!/usr/bin/env perl
#
# Gennep
# Vennep
# Keppel
# Soeren
#

use v5.10.1;
use strict;
use POSIX qw(floor);

############################################################################
# constants

my @CITY_UNIFIXES = qw(Barf Burp Drummel Gonsp Hark Jurk Kimmel Korst Nisk Pik Put Rinsp Smirk);

my @CITY_PREFIXES = qw(
    Aa Aalbesser Acht Achter Beek Blasper Blerker Blinkers Boeren Borrel Casper
    Couwen Daver Duin Eem Eider Even Flens Gaffel Grebben Groenen Grooten Gruns
    Jilser Heer Heien Hoogen Kaal Kemper Kerk Klammer Kloot Kluitje Konkel Kunder
    Loos Loden Maagden Middel Negen Nijen Over Ouden Poppel Prakke Riet Rood Scharrel
    Schel Scherpen Schoon Tonnen Uiter Valken Voren Water Willems Woud IJ Zeven
    Zijder Zonkel
    Sint-Michiels Sint-Andreas Sint-Anna
);

my @CITY_SUFFIXES = qw(
    beek berg broek burg dam dijk dorp drecht heim hoef hoek holt horn hoven
    huizen kamp kerk kerke land loo meer oord polder rade rijk rode sloot sluis
    stad veen veld vliet voort wijk woude zand zeel zicht zijde zijl
);

my @CITY_EMBELLISHMENTS = qw(Noord Zuid Oost West Oud Nieuw Hoog Laag Groot Klein);

my @RIVERS = qw(A Bummel Donkel Kreek Loens);

my @STREET_PREFIXES = (
    qw(Molen Kerk Stations Klooster Hoofd Ring Wijngaard), # city features
    qw(Duin Beekdal Dijkzicht Moeras Vallei), # landscape features
    qw(Dauw Dauwdruppel Zonnegloeds Zonnewende), # natural phenomena
    qw(Hooiberg Gaffel Ploeg Fuik Klompen), # farm features
    qw(Ruiter Schoenlapper Leerlooier Mandenmaker), # old professions
    qw(Ouverture Symfonie Aria Concert Viool Harp), # classical music
    qw(Agaat Saffier Jade Emerald Onyx), # precious stones
    qw(Sumatra Java Celebes Suriname Aruba Curaçao), # islands
    qw(Bloesem Klaver Korenbloem Hortensia Forsythia Distel Braam Vlas Riet), # plants
    qw(Plataan Berken Beuken Eiken Wilgen Hazelaar Dennen Iepen Elzen), # trees
    qw(Merel Kievit Havik Nachtegaal Kwartel Zwaluw Valken Reiger), # birds
    qw(Ossen Vlinder Vuurvlieg Libelle Egel Hommel), # animals
    qw(Beatrix Bernhard Emma Juliana Máxima Nassau Wilhelmina), # royal house
    qw(Tollens Newton Einstein Planck), # scientists
    qw(Rietveld Beethoven Mozart Mahler Spinoza Sweelinck Mondriaan Liszt), # composers/painters
);

my @STREET_SUFFIXES = qw(
    allee dreef gas gracht haven hof kade kant laan pad
    park plaats plein singel steeg straat weg
);

my @HOUSENUMBER_SUFFIXES = qw(-hs -I -II -III bis A B C D); # ZW RD

############################################################################
# functions

sub pick {
    my @set = @_;
    return $set[floor(rand() * $#set)]
}

sub street {
    return pick(@STREET_PREFIXES) . pick(@STREET_SUFFIXES);
}

sub housenumber {
    my $number = floor(2 * exp rand 5);
    my $suffix = (rand > .95) ? pick(@HOUSENUMBER_SUFFIXES) : '';
    return $number . $suffix;
}

sub postcode {
    return floor(rand(9000) + 1000) . " " . chr(65 + rand 26) . chr(65 + rand 26);
}

sub city {
    if (rand() < .85) {
        # 85 %
        return pick(@CITY_PREFIXES) . pick(@CITY_SUFFIXES);
    } elsif (rand() < .333) {
        # 5 %
        return pick(@CITY_UNIFIXES) . ' aan de ' . pick(@RIVERS);
    } elsif (rand() < .5) {
        # 5 %
        return pick(@CITY_PREFIXES) . pick(@CITY_SUFFIXES) . '-' . pick(@CITY_EMBELLISHMENTS);
    } else {
        # 5 %
        return pick(@CITY_EMBELLISHMENTS) . '-' . pick(@CITY_PREFIXES) . pick(@CITY_SUFFIXES);
    }
}

sub output {
    say street, " ", housenumber;
    say postcode, " ", city;
}

sub main {
    my ($count) = @_;
    for (1 .. $count || 1) {
        output;
    }
}

############################################################################
# main

main @ARGV;

