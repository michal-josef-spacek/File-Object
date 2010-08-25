# Modules.
use File::Object;
use Test::More 'tests' => 1;

# Debug message.
print "Testing: file() method.\n";

# Test.
my $obj = File::Object->new;
my $ret = $obj->file;
ok($ret->isa('File::Object'));
