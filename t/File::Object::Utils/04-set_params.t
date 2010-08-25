# Modules.
use English qw(-no_match_vars);
use File::Object::Utils qw(set_params);
use Test::More 'tests' => 2;

# Debug message.
print "Testing: set_params() subroutine.\n";

# Test.
my $self = {
	'key' => undef,
};
set_params($self, 'key', 'value');
is($self->{'key'}, 'value');

# Test.
eval {
	set_params($self, 'bad_key', 'value');
};
is($EVAL_ERROR, "Unknown parameter 'bad_key'.\n");
