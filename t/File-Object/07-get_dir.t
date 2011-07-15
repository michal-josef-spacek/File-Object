# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;
use Test::More 'tests' => 2;

# Test.
my $obj = File::Object->new;
is($obj->get_dir, 'File-Object', 'Directory of running script.');

# Test.
$obj = File::Object->new(
	'dir' => ['1', '2'],
);
is($obj->get_dir, '2', 'Directory sets by constructor.');
