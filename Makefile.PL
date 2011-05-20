# Modules.
use ExtUtils::MakeMaker;

# Definition.
WriteMakefile(
	'AUTHOR' => 'Michal Špaček <skim@cpan.org>',
	'BUILD_REQUIRES' => {
		'Cwd' => 0,
		'English' => 0,
		'File::Spec::Functions' => 0,
		'FindBin' => 0,
		'Test::More' => 0,
		'Test::Pod' => 0,
		'Test::Pod::Coverage' => 0,
	},
	'CONFIGURE_REQUIRES' => {
		'ExtUtils::MakeMaker' => 0,
	},
	'NAME' => 'File::Object',
	'PREREQ_PM' => {
		'Class::Utils' => 0.01,
		'Error::Pure' => 0.01,
		'File::Spec::Functions' => 0,
		'FindBin' => 0,
	},
	'VERSION' => 0.01,
	'test' => {
		'TESTS' => 't/File::Object/*.t',
	},
);
