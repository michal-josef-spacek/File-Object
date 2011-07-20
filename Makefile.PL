# Pragmas.
use strict;
use warnings;

# Modules.
use inc::Module::Install;

# Definition.
abstract 'Object system for filesystem paths.';
author 'Michal Špaček <skim@cpan.org>';
license 'bsd';
name 'File-Object';
requires 'Class::Utils' => 0.01;
requires 'Error::Pure' => 0.01;
requires 'File::Spec::Functions' => 0;
requires 'FindBin' => 0;
resources 'repository' => {
	'url' => 'git://github.com/tupinek/File-Object',
	'web' => 'https://github.com/tupinek/File-Object',
	'type' => 'git',
};
test_requires 'Cwd' => 0;
test_requires 'English' => 0;
test_requires 'File::Spec::Functions' => 0;
test_requires 'FindBin' => 0;
test_requires 'Test::More' => 0;
test_requires 'Test::Pod' => 0;
test_requires 'Test::Pod::Coverage' => 0;
tests_recursive;
version '0.03';

# Run.
WriteAll();
