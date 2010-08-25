# Modules.
use File::Object;
use Test::More 'tests' => 1;

# Debug message.
print "Testing: up() method.\n";

# Test.
my $obj = File::Object->new;
my $ret = $obj->up;
ok($ret->isa('File::Object'));
