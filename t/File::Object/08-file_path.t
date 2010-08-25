# Modules.
use File::Object;
use Test::More 'tests' => 1;

# Debug message.
print "Testing: file_path() method.\n";

# Test.
my $obj = File::Object->new;
my $ret = $obj->file_path;
ok($ret->isa('File::Object'));
