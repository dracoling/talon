#!/usr/bin/perl

# Dumper module
# by dracoling
# for when you absolutely have to have too much information about whats going on in talon's mind.

use strict;
package talonplug::dumper;
use Data::Dumper;

sub new {
	my $self = { };
	return bless $self;
}

sub on_public {
	my ($self, $irc, $sql, $message, $nick, $respond, $host ) = @_;
    print Dumper($irc);
}
1;
