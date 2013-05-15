#!/usr/bin/env perl

use strict;

use feature 'say';

my $PROFILE_CONFIG = 'profile_config';
my $PROFILE_NAME = 'profile_id';

sub read_profile_name {
    return undef unless -f $PROFILE_NAME;
    open my $fp, '<', $PROFILE_NAME;
    my $value = <$fp>;
    close $fp;
    chomp $value;
    return $value;
}

sub pick_one {
    my $alts = shift;

    my $i = 0;

    say "Pick one:";

    for (@$alts) {
        say "$i) $_";
        ++$i;
    }

    while (1) {
        print "Pick one: ";

        my $input = undef;

        unless ($input = <STDIN>) {
            die "abort";
        }

        if (my $choice = $alts->[$input]) {
            return $choice;
        }

        say "Not a valid choice: $input, try again";
    }
}

sub select_profile {
    my $profiles = shift;

    my $i = 0;

    my @alts = keys %$profiles;

    my $choice = pick_one \@alts;

    say "writing choice to $PROFILE_NAME";
    open my $fp, '>', $PROFILE_NAME;
    print $fp "$choice\n";
    close $fp;

    return $choice;
}

sub main {
    die "Missing file: $PROFILE_CONFIG" unless -f $PROFILE_CONFIG;

    my $target = $ARGV[0];
    my $source = $ARGV[1];

    die "Missing source: $source" unless -f $source;

    my %config = do $PROFILE_CONFIG;
    my $profiles = $config{'profiles'};

    my $profile_name = read_profile_name;

    $profile_name = select_profile $profiles unless $profile_name;

    my $profile = $config{ 'profiles' }->{ $profile_name };

    die "No such profile: $profile_name" unless $profile;

    my $args = join ' ', map { "-D$_=\"$profile->{$_}\"" } keys(%$profile);

    say "Generating; $source -> $target";
    system "m4 $args $source > $target";
    return 0;
}

exit main unless caller;
