# Modules.
use File::Object;
use Test::More 'tests' => 1;

print "Testing: version.\n";
is($File::Object::VERSION, '0.01');
