# Modules.
use File::Object;
use FindBin qw($Bin);
use Test::More 'tests' => 2;

# Debug message.
print "Testing: serialize() method.\n";

# Test.
my $obj = File::Object->new;
my $ret = $obj->serialize;
my $rigth_ret = $Bin;
is($ret, $rigth_ret);

# Test.
$obj = File::Object->new(
	'file' => '1/2/3/ex1.txt',
	'type' => 'file',
);
$ret = $obj->serialize;
is($ret, '1/2/3/ex1.txt');
