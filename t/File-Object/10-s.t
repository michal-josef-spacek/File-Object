# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;
use FindBin qw($Bin);
use Test::More 'tests' => 2;

# Test.
my $obj = File::Object->new;
is($obj->s, $Bin, 'Actual directory.');

# Test.
$obj = File::Object->new(
	'dir' => [1, 2, 3],
	'file' => 'ex1.txt',
	'type' => 'file',
);
is($obj->s, '1/2/3/ex1.txt', 'Path to specified file.');
