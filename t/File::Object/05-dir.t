# Modules.
use File::Object;
use Test::More 'tests' => 1;

# Debug message.
print "Testing: dir() method.\n";

# Test.
my $obj = File::Object->new;
my $ret = $obj->dir;
ok($ret->isa('File::Object'));
