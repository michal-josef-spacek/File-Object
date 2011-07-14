# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;
use FindBin qw($Bin);
use Test::More 'tests' => 2;

# Test.
my $obj = File::Object->new;
my $ret = $obj->s;
my $rigth_ret = $Bin;
is($ret, $rigth_ret);

# Test.
$obj = File::Object->new(
	'dir' => [1, 2, 3],
	'file' => 'ex1.txt',
	'type' => 'file',
);
$ret = $obj->s;
is($ret, '1/2/3/ex1.txt');