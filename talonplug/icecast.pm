#!/usr/bin/perl

# icecast module
# by dracoling

use strict;
use WWW::Mechanize;
package talonplug::icecast;

sub new {
	my $self = { };
	return bless $self;
}

sub on_public {
	my ($self, $irc, $sql, $message, $nick, $respond, $host ) = @_;
	
	if ( $message =~ /^!listeners/ ) {
		my $status = $self->_periodic();
		if (ref($status) eq 'HASH') {
			$irc->yield( privmsg => $respond => ">> ". $status->{'listeners'} . ' current listeners');
		} else {
			$irc->yield( privmsg => $respond => ">> The stream appears to be offline.");
		}
	}
	if ( $message =~ /^!np/ ) {
		if ( $message =~ /^!np-fallback/ ) {
			my $status = $self->_status_fallback();
			if (ref($status) eq 'HASH') {
				my $playing = '';
				if (defined($status->{'artist'})) { $playing .= $status->{'artist'}; }
				if (defined($status->{'title'})) {
					if ($playing ne '') { $playing .= ' - '; }
					$playing .= $status->{'title'};
				}
				if ($playing eq '') { $playing = 'unknown track'; }
				$irc->yield( privmsg => $respond => "[fallback] Now playing: ". $playing);
			} else {
				$irc->yield( privmsg => $respond => "The stream appears to be offline. That's really bad, you should probably call someone about that.");
			}
		} else {
			my $status = $self->_periodic();
			if (ref($status) eq 'HASH') {
				my $playing = '';
				if (defined($status->{'artist'})) { $playing .= $status->{'artist'}; }
				if (defined($status->{'title'})) {
					if ($playing ne '') { $playing .= ' - '; }
					$playing .= $status->{'title'};
				}
				if ($playing eq '') { $playing = 'unknown track'; }
				$irc->yield( privmsg => $respond => "Now playing: ". $playing);
			} else {
				$irc->yield( privmsg => $respond => "The stream appears to be offline.");
			}
		}
	}
	if ( $message =~ /^!radio-status/ ) {
		my $status = $self->_periodic();
		if (ref($status) eq 'HASH') {
			my $playing = '';
			if (defined($status->{'artist'})) { $playing .= $status->{'artist'}; }
			if (defined($status->{'title'})) {
				if ($playing ne '') { $playing .= ' - '; }
				$playing .= $status->{'title'};
			}
			if ($playing eq '') { $playing = 'unknown track'; }
			$irc->yield( privmsg => $respond => "Current Stream: " . $status->{'server_name'});
			$irc->yield( privmsg => $respond => "Now playing: ". $playing .' for ' . $status->{'listeners'} . ' listeners');
			$irc->yield( privmsg => $respond => "Listen in: " . $status->{'listenurl'} . " (".$status->{'server_type'}.")"); 
		} else {
			$irc->yield( privmsg => $respond => "The stream appears to be offline.");
		}
	}
														        
}
sub _periodic {
	my ($self) = @_;
	my $status = $self->_status();
	if (ref($status) eq 'HASH') {
		print "[icecast] Stream online.\n"
	} else {
		print "[icecast] Stream offline.\n"
	}    
	return $status;
}
sub _status {
	my ($self) = @_;
	my $url = 'http://10.41.8.53:8000/status3.xsl';
	my $mech = WWW::Mechanize->new();
	$mech->get($url);
	use YAML;
	my $data = Load($mech->content . "\n");
	$data = $data->{'/stream'}; #only read data for /stream
	return $data;
}
sub _status_fallback {
	my ($self) = @_;
	my $url = 'http://10.41.8.53:8000/status3.xsl';
	my $mech = WWW::Mechanize->new();
	$mech->get($url);
	use YAML;
	my $data = Load($mech->content . "\n");
	$data = $data->{'/fallback'}; #only read data for /stream
	return $data;
}
sub about {
	return "Icecast monitor module.";
}

sub help {
	return "!radio-status shows all stream info\n"
	      ."!np gives the current track info\n"
	      ."!listeners gives the current connection count";
}

1;
