# Modules.
use Test::Pod::Coverage 'tests' => 1;

print "Testing: Pod coverage.\n";
pod_coverage_ok('File::Object::Utils', 'File::Object::Utils is covered.');
