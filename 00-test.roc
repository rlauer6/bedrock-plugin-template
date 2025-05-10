#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;
use English qw(no_match_vars);

use Test::More;

use_ok("BLM::Startup::<var $input.module>");

done_testing;

1;
