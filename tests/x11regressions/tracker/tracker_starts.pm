use base "basetest";
use testapi;

# Case 1248739 - Beagle: beagle-search starts
# Modify to : Tracker: tracker-needle starts

sub run() {
    my $self = shift;
    x11_start_program("tracker-needle");
    sleep 2;
    wait_idle;
    assert_screen 'test-tracker_starts-1', 3;
    send_key "alt-f4";
    sleep 2;

    # assert_screen 'test-tracker_starts-2', 3;
}

1;
# vim: set sw=4 et:
