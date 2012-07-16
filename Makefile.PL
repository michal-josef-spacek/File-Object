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
requires 'Class::Utils' => 0.03;
requires 'Error::Pure' => 0.08;
requires 'File::Spec::Functions' => 0;
requires 'FindBin' => 0;
resources 'bugtracker' => 'https://rt.cpan.org/Public/Dist/Display.html'.
	'?Name=File-Object';
resources 'homepage' => 'https://github.com/tupinek/File-Object';
resources 'repository' => 'git://github.com/tupinek/File-Object';
test_requires 'Cwd' => 0;
test_requires 'English' => 0;
test_requires 'File::Spec::Functions' => 0;
test_requires 'FindBin' => 0;
test_requires 'Test::More' => 0;
test_requires 'Test::Pod' => 0;
test_requires 'Test::Pod::Coverage' => 0;
tests_recursive;
version '0.06';

# Run.
WriteAll();
