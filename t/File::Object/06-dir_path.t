# Modules.
use File::Object;
use Test::More 'tests' => 1;

# Debug message.
print "Testing: dir_path() method.\n";

# Test.
my $obj = File::Object->new;
my $ret = $obj->dir_path;
ok($ret->isa('File::Object'));
