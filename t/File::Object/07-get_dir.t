# Modules.
use File::Object;
use Test::More 'tests' => 2;

# Test.
my $obj = File::Object->new;
my $ret = $obj->get_dir;
# XXX Bad test.
ok($ret->isa('File::Object'));

# Test.
$obj = File::Object->new(
	'dir' => ['1', '2'],
);
$ret = $obj->get_dir;
is($ret, '2');
