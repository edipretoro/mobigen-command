#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Mobigen::Command' );
}

diag( "Testing Mobigen::Command $Mobigen::Command::VERSION, Perl $], $^X" );
