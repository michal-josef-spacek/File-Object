# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;
use Test::More 'tests' => 1;

# Test.
is($File::Object::VERSION, 0.06, 'Version.');
