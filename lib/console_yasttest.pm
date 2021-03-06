# Base for YaST tests.  Switches to text console 2 and uploady y2logs

package console_yasttest;
use base "opensusebasetest";

use testapi;

sub post_fail_hook() {
    my $self = shift;

    send_key "ctrl-alt-f2";
    assert_screen("text-login", 10);
    type_string "root\n";
    sleep 2;
    type_password;
    type_string "\n";
    sleep 1;

    save_screenshot;

    my $fn = sprintf '/tmp/y2logs-%s.tar.bz2', ref $self;
    type_string "save_y2logs $fn\n";
    upload_logs $fn;
    save_screenshot;
}

sub post_run_hook {
    my ($self) = @_;

    $self->clear_and_verify_console;
}

1;
# vim: set sw=4 et:
