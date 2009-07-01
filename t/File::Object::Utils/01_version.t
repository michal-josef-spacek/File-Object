# Modules.
use File::Object::Utils;
use Test::More 'tests' => 1;

print "Testing: version.\n";
is($File::Object::Utils::VERSION, '0.01');
