use base "y2logsstep";
use strict;
use testapi;

sub run(){
    my $self=shift;

    if (!get_var('UPGRADE')) {
        # assert to ensure screen is ready for typing before typing
        assert_screen 'network-config-ready', 10;

        # Hostname
        if (!check_var('DESKTOP', 'textmode')) {
            send_key "alt-h";
        }
        for (1 .. 10) { send_key 'backspace'; }
        type_string "susetest";
        send_key "tab";
        for (1 .. 10) { send_key 'backspace'; }
        type_string "zq1.de";

        assert_screen 'hostname-typed', 4;
        send_key $cmd{next};

        # network conf
        assert_screen 'network-config-done', 40; # longwait Net|DSL|Modem
        if (check_screen 'workaround-boo914288') {
            record_soft_failure;
        }
        send_key $cmd{next};
    }

    assert_screen 'test-internet-connection', 60;
    if (check_screen 'workaround-boo913722') {
        record_soft_failure;
    }
    send_key $cmd{next};

    # if a BETA run, allow server-side-errors and handle gracefully
    if(get_var("BETA")) {
        if (check_screen 'server-side-error', 90) {
            send_key "alt-o";
            record_soft_failure;
        }
    }
    elsif (check_screen 'server-side-error', 90) {
        die "Problem downloading release notes on non-beta";
    }

    # release notes download can take a while
    assert_screen 'internet-is-fine', 90;
    send_key $cmd{next};
}

1;
