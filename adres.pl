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
use Getopt::Std;

my %opts;

############################################################################
# constants

my @CITY_UNIFIXES = qw(Barf Burp Drummel Gonsp Hark Jurk Kimmel Korst Nisk Pik Put Rinsp Smirk);

my @CITY_PREFIXES = qw(
    Aa Aalbesser Acht Achter Beek Blasper Blerker Blinkers Boeren Borrel Casper
    Couwen Daver Duin Eem Eider Even Flens Gaffel Grebben Groenen Grooten Gruns
    Jilser Heer Heien Hoogen Kaal Kemper Kerk Klammer Kloot Kluitje Konkel Kunder
    Loos Loden Maagden Middel Negen Nijen Over Ouden Poppel Prakke Riet Rood
    Scharrel Schel Scherpen Schoon Tonnen Uiter Valken Voren Water Willems Woud IJ
    Zeven Zijder Zonkel
    Sint-Andreas Sint-Anna Sint-Michiels
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
    qw(Fuik Gaffel Hooiberg Klompen Ploeg Schoof), # farm features
    qw(Leerlooier Mandenmaker Ruiter Schoenlapper), # old professions
    qw(Aria Aubade Concert Harp Ouverture Pianola Symfonie Viool), # classical music
    qw(Agaat Diamant Jade Onyx Robijn Saffier Smaragd Topaas), # precious stones
    qw(Borneo Celebes Java Sumatra Timor Suriname Aruba Curaçao), # islands
    qw(Bloesem Braam Distel Forsythia Hortensia Klaver Korenbloem Riet Vlas), # plants
    qw(Berken Beuken Dennen Eiken Elzen Hazelaar Iepen Plataan Wilgen), # trees
    qw(Havik Kievit Kwartel Merel Nachtegaal Reiger Valken Zwaluw), # birds
    qw(Egel Hommel Libelle Ossen Vlinder Vuurvlieg), # animals
    qw(Beatrix Bernhard Emma Juliana Máxima Nassau Wilhelmina), # royal house
    qw(Celsius Curie Darwin Einstein Galilei Newton Planck Tollens), # scientists
    qw(Bach Beethoven Liszt Mahler Mondriaan Mozart Rietveld Spinoza Sweelinck), # composers/painters
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
    if ($opts{c}) {
        say city;
    } elsif ($opts{s}) {
        say street;
    } else {
        say street, " ", housenumber;
        say postcode, " ", city;
    }
}

sub main {
    my ($count) = @_;
    for (1 .. $count // 1) {
        output;
    }
}

############################################################################
# main

getopts('cs', \%opts); 
main @ARGV;

__END__

##########################################################################
# pod documentation

# section 6

=pod {{{

=head1 NAME

B<adres> - Generate Humorous Dutch Addresses

=head1 SYNOPSIS

B<adres> [ B<-c> ] [ B<-s> ] [ I<count> ]

=head1 DESCRIPTION

This program generates funny Dutch postal addresses.
These can be used for fun or when anonymous data is needed.

It was inspired by this Heinz cartoon: L<https://tinyurl.com/heinz-cities>

By default, a full address is generated, with house number and postal code.

=head1 OPTIONS

=over

=item B<-c>

Generate a city name only. Note: B<-c> takes precedence over B<-s>.

=item B<-s>

Generate a street name only.

=back

=cut }}}

# vim: set tabstop=4 shiftwidth=4 foldenable foldmethod=marker:

