package Maypole::Plugin::Loader;

use strict;
use NEXT;

our $VERSION = '0.03';

=head1 NAME

Maypole::Plugin::Loader - Require all available model class modules

=head1 SYNOPSIS

    package BeerDB;

    use Maypole::Application qw(Loader);

    BeerDB->setup('dbi:Pg:dbname=beerdb', 'myuser', 'mypass');

=head1 DESCRIPTION

Requires all available model class modules for you.

So you can just do this:

    package BeerDB;

    use Maypole::Application qw(Loader);

    BeerDB->setup('dbi:Pg:dbname=beerdb', 'myuser', 'mypass');

Instead of this:

    package BeerDB;

    use Maypole::Application;

    BeerDB->setup('dbi:Pg:dbname=beerdb', 'myuser', 'mypass');
    BeerDB::Brewery->require;
    BeerDB::Beer->require;
    BeerDB::Handpump->require;
    BeerDB::Pub->require;

=cut

sub setup {
    my $r = shift;
    $r->NEXT::DISTINCT::setup(@_);
    for my $m ( @{ $r->config->{classes} } ) {
        unless ( $m->require ) {
            warn qq(Loading "$m" failed: "$@") if $r->debug;
        }
    }
}

=head1 AUTHOR

Sebastian Riedel, C<sri@oook.de>

=head1 THANK YOU

Max Maischein

=head1 LICENSE

This library is free software. You can redistribute it and/or modify it under
the same terms as perl itself.

=cut

1;
