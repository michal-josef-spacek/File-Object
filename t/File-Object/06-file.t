# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;
use File::Spec::Functions qw(catfile);
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
$ret = $obj->file('subdir', 'other_file')->s;
my $right_ret = catfile('dir', 'subdir', 'other_file');
is($ret, $right_ret, 'Test for file() with subdir and other_file.');
