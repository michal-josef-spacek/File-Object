# Modules.
use File::Object;
use Test::More 'tests' => 1;

# Test.
my $obj = File::Object->new;
my $ret = $obj->dir;
ok($ret->isa('File::Object'));
