#!/usr/bin/env perl -w

use strict;
use warnings;

use lib '../lib';
use Mobigen::Command;

my $mobi = Mobigen::Command->new();

$mobi->input_file(shift) or die "Usage: $0 file.html\n";
$mobi->execute();
