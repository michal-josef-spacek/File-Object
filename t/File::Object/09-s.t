# Modules.
use File::Object;
use FindBin qw($Bin);
use Test::More 'tests' => 2;

# Debug message.
print "Testing: s() method.\n";

# Test.
my $obj = File::Object->new;
my $ret = $obj->s;
my $rigth_ret = $Bin;
is($ret, $rigth_ret);

# Test.
$obj = File::Object->new(
	'file' => '1/2/3/ex1.txt',
	'type' => 'file',
);
$ret = $obj->s;
is($ret, '1/2/3/ex1.txt');
