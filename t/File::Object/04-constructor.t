# Modules.
use English qw(-no_match_vars);
use File::Object;
use Test::More 'tests' => 4;

# Debug message.
print "Testing: new() constructor.\n";

# Test.
my $obj;
eval {
	$obj = File::Object->new('');
};
is($EVAL_ERROR, "Unknown parameter ''.\n");

# Test.
eval {
	$obj = File::Object->new(
		'something' => 'value',
	);
};
is($EVAL_ERROR, "Unknown parameter 'something'.\n");

# Test.
$obj = File::Object->new;
ok(defined $obj);
ok($obj->isa('File::Object'));
