# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;
use Test::More 'tests' => 2;

# Test.
my $obj = File::Object->new;
my $ret = $obj->dir;
isa_ok($ret, 'File::Object');

# Test.
$obj = File::Object->new(
	'dir' => ['dir'],
	'type' => 'dir',
);
is($obj->dir('subdir', undef)->s, 'dir/subdir',
	'Test for dir() with subdir and undef.');
