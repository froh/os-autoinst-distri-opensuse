package rescuecdstep;
use base "opensusebasetest";
use testapi;

# Base class for all RESCUECD tests

sub test_flags() {
    return { 'important' => 1, 'fatal' => 1 };
}

1;
# vim: set sw=4 et:
