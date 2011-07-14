# Pragmas.
use strict;
use warnings;

# Modules.
use English qw(-no_match_vars);
use File::Object;
use Test::More 'tests' => 6;

# Test.
eval {
	File::Object->new('');
};
is($EVAL_ERROR, "Unknown parameter ''.\n", 'Bad \'\' parameter.');

# Test.
eval {
	File::Object->new(
		'something' => 'value',
	);
};
is($EVAL_ERROR, "Unknown parameter 'something'.\n",
	'Bad \'something\' parameter.');

# Test.
eval {
	File::Object->new(
		'type' => 'XXX',
	);
};
is($EVAL_ERROR, "Bad 'type' parameter.\n", 'Bad \'type\' parameter.');

# Test.
eval {
	File::Object->new(
		'dir' => 'BAD_ARRAY',
	);
};
is($EVAL_ERROR, "'dir' parameter must be a reference to array.\n",
	'Bad \'dir\' parameter.');

# Test.
eval {
	File::Object->new(
		'type' => undef,
	);
};
is($EVAL_ERROR, "Bad 'type' parameter.\n", 'Bad undefined \'type\' parameter.');

# Test.
my $obj = File::Object->new;
isa_ok($obj, 'File::Object');
