# $Id: on_fail_regex.t 717 2005-09-30 05:52:12Z autarch $
use strict;
use lib 'inc';
use blib;
use Test::More tests => 3;
use vars qw( $class );

BEGIN {
    $class = 'DateTime::Format::Builder';
    use_ok $class;
}

{
    eval q!package DTFB::FailRegexTest;
        use DateTime::Format::Builder (
            parsers => {
                parse_datetime => [
                    {
                        regex => qr|\d{4}-\d{2}-\d{2}|,
                        params => [ qw(year month day) ]
                    }
                ]
            }
        );
    !;
    ok( !$@, "Made class" );
    diag $@ if $@;

    my $o = DTFB::FailRegexTest->new();
    my $str = eval { $o->parse_datetime("FooBlah") };
    my $e = $@;
    my $file = __FILE__;
    like($e, qr(at \Q$file\E), "Should croak from this file");
}
