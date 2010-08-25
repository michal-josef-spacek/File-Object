# Modules.
use File::Object;
use Test::More 'tests' => 2;

# Debug message.
print "Testing: get_file() method.\n";

# Test.
my $obj = File::Object->new;
my $ret = $obj->get_file;
is($ret, undef);

# Test.
$obj = File::Object->new(
	'file' => '1/2/3/ex1.txt',
	'type' => 'file',
);
$ret = $obj->get_file;
is($ret, 'ex1.txt');
