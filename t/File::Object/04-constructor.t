# Modules.
use English qw(-no_match_vars);
use File::Object;
use Test::More 'tests' => 3;

# Test.
eval {
	File::Object->new('');
};
is($EVAL_ERROR, "Unknown parameter ''.\n");

# Test.
eval {
	File::Object->new(
		'something' => 'value',
	);
};
is($EVAL_ERROR, "Unknown parameter 'something'.\n");

# Test.
my $obj = File::Object->new;
isa_ok($obj, 'File::Object');
