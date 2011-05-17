# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;
use Test::More 'tests' => 1;

# Test.
my $obj = File::Object->new;
my $ret = $obj->up;
ok($ret->isa('File::Object'));
