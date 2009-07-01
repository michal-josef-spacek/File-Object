# Modules.
use Test::More 'tests' => 2;

BEGIN {
	print "Usage tests.\n";
	use_ok('File::Object::Utils');
}
require_ok('File::Object::Utils');
