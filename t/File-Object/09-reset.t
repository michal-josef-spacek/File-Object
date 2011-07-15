# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;
use File::Spec::Functions qw(catdir catfile);
use FindBin qw($Bin $Script);
use Test::More 'tests' => 12;

# Test.
my $obj = File::Object->new(
	'type' => 'dir',
);
is($obj->s, $Bin, 'Directory of running directory.');
$obj->dir('subdir');
is($obj->s, catdir($Bin, 'subdir'), 'Actual directory with subdirectory.');
$obj->reset;
is($obj->s, $Bin, 'Directory of running script.');

# Test.
$obj = File::Object->new(
	'dir' => ['dir1'],
	'type' => 'dir',
);
is($obj->s, 'dir1', 'Directory defined in constructor.');
$obj->dir('dir2');
is($obj->s, 'dir1/dir2', 'Directory with subdirectory.');
$obj->reset;
is($obj->s, 'dir1', 'Directory defined in constructor.');

# Test.
$obj = File::Object->new(
	'type' => 'file',
);
is($obj->s, catfile($Bin, $Script), 'Running file.');
$obj->file('other_file');
is($obj->s, catfile($Bin, 'other_file'), 'Other file in actual directory.');
$obj->reset;
is($obj->s, catfile($Bin, $Script), 'Running file.');

# Test.
$obj = File::Object->new(
	'dir' => ['dir'],
	'file' => 'file',
	'type' => 'file',
);
is($obj->s, 'dir/file', 'Path to file defined in constructor.');
$obj->file('other_file');
is($obj->s, 'dir/other_file', 'Path to other file.');
$obj->reset;
is($obj->s, 'dir/file', 'Path to file defined in constructor.');
