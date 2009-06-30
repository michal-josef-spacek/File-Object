# Modules.
use ExtUtils::MakeMaker;

# Definition.
WriteMakefile(
	'NAME' => 'File::Object',
	'PREREQ_PM' => {
		'Error::Simple::Multiple' => 0.05,
		'Readonly' => 0,
	},
	'VERSION' => 0.01,
	'test' => {
		'TESTS' => 't/File::Object/*.t '.
			't/File::Object::Utils/*.t',
	},
);
