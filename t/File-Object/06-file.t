# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;
use Test::More 'tests' => 2;

# Test.
my $obj = File::Object->new;
my $ret = $obj->file;
isa_ok($ret, 'File::Object');

# Test.
$obj = File::Object->new(
	'file' => 'file',
	'dir' => ['dir'],
	'type' => 'file',
);
is($obj->file('subdir', 'other_file')->s, 'dir/subdir/other_file',
	'Test for file() with subdir and other_file.');
