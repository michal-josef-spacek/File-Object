package File::Object;

# Pragmas.
use strict;
use warnings;

# Modules.
use Class::Utils qw(set_params);
use Error::Pure qw(err);
use FindBin qw($Bin $Script);
use File::Spec::Functions qw(catdir catfile splitdir);

# Version.
our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Dir path.
	$self->{'dir'} = [];

	# File path.
	$self->{'file'} = undef;

	# Type of path.
	$self->{'type'} = 'dir';

	# Process parameters.
	set_params($self, @params);

	# Check to right 'type'.
	if (! $self->{'type'} || ($self->{'type'} ne 'file' 
		&& $self->{'type'} ne 'dir')) {

		err 'Bad \'type\' parameter.';
	}

	# Check to dir.
	if (ref $self->{'dir'} ne 'ARRAY') {
		err '\'dir\' parameter must be a reference to array.';
	}

	# Reset to constructor values.
	$self->reset;

	# Object.
	return $self;
}

# Add dir.
sub dir {
	my ($self, @dirs) = @_;
	foreach my $dir (@dirs) {
		if (defined $dir) {
			$self->_dir($dir);
		}
	}

	# Object.
	return $self;
}

# Add file.
sub file {
	my ($self, @dirs_or_file) = @_;
	my $file = pop @dirs_or_file;
	foreach my $dir (@dirs_or_file) {
		if (defined $dir) {
			$self->_dir($dir);
		}
	}
	$self->_file($file);

	# Object.
	return $self;
}


# Get dir.
sub get_dir {
	my ($self, $dir_num) = @_;
	$dir_num ||= 1;
	if ($self->{'type'} eq 'file') {
		$dir_num++;
	}
	return $self->{'path'}->[-$dir_num];
}

# Get file.
sub get_file {
	my $self = shift;
	if ($self->{'type'} eq 'file') {
		return $self->{'path'}->[-1];
	} else {
		return;	
	}
}

# Reset.
sub reset {
	my $self = shift;
	if ($self->{'type'} eq 'file') {
		if ($self->{'file'}) {
			$self->{'path'} = [@{$self->{'dir'}}, $self->{'file'}];
		} else {
			$self->{'path'} = [splitdir($Bin), $Script];
		}
	} else {
		if (@{$self->{'dir'}}) {
			$self->{'path'} = [@{$self->{'dir'}}];
		} else {
			$self->{'path'} = [splitdir($Bin)];
		}
	}
	return $self;
}

# Serialize path.
sub s {
	my $self = shift;
	if ($self->{'type'} eq 'dir') {
		return catdir(@{$self->{'path'}});
	} else {
		return catfile(@{$self->{'path'}});
	}
}

# Go to parent directory.
sub up {
	my ($self, $up_num) = @_;

	# Check number and positive number.
	if (! $up_num || $up_num !~ /^\d$/ || $up_num < 1) {
		$up_num = 1;
	}

	# Process.
	foreach (1 .. $up_num) {
		if ($self->{'type'} eq 'file') {
			if (@{$self->{'path'}} > 1) {
				$self->{'type'} = 'dir';
				splice @{$self->{'path'}}, -2;
			} else {
				err 'Cannot go up.', 'PATH', $self->s;
			}
		} else {
			if (@{$self->{'path'}}) {
				pop @{$self->{'path'}};
			} else {
				err 'Cannot go up.', 'PATH', $self->s;
			}
		}
	}

	# Object.
	return $self;
}

# Add dir array.
sub _dir {
	my ($self, @dir) = @_;	
	if ($self->{'type'} eq 'file') {
		$self->{'type'} = 'dir';
		pop @{$self->{'path'}};
	}
	push @{$self->{'path'}}, @dir;
	return;
}

# Add file array.
sub _file {
	my ($self, $file) = @_;
	if ($self->{'type'} eq 'file') {
		pop @{$self->{'path'}};
		push @{$self->{'path'}}, $file;
	} else {
		push @{$self->{'path'}}, $file;
		$self->{'type'} = 'file';
	}
	return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

File::Object - Object system for filesystem paths.

=head1 SYNOPSIS

 use File::Object;
 my $obj = File::Object->new(%parameters);
 $obj->dir($dir);
 $obj->file($file);
 my $dir = $obj->get_dir($dir_num);
 my $file = $obj->get_file;
 $obj->reset;
 my $path = $obj->s;
 $obj->up($num);

=head1 METHODS

=over 8

=item C<new(%parameters)>

Constructor.

=over 8

=item * C<dir>

 Directory path.

=item * C<file>

 File path.

=item * C<type>

 Type of path.
 Types:
 - file
 - dir

=back

=item C<dir(@dir)>

TODO
 Returns main object.

=item C<file(@file)>

TODO
 Returns main object.

=item C<get_dir($dir_num)>

 Returns $dir_num level directory.
 Default value of $dir_num is 1.

=item C<get_file()>

 Returns:
 - Filename if object is file path.
 - undef if object is directory path.

=item C<reset()>

 Reset to constructor values.

=item C<s()>

 Serialize path and return.

=item C<up($up_num)>

TODO
 Returns main object.

=back

=head1 ERRORS

 Mine:
         'dir' parameter must be a reference to array.
         Bad 'type' parameter.
         Cannot go up.
                 PATH -> path;

 From Class::Utils::set_params():
         Unknown parameter '%s'.

=head1 EXAMPLE1

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use File::Object;

 # Print actual directory path.
 print File::Object->new->s."\n";

=head1 EXAMPLE2

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use File::Object;

 # Print parent directory path.
 print File::Object->new->up->s."\n";

=head1 EXAMPLE3

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use File::Object;

 # Object with directory path.
 my $obj = File::Object->new(
         'dir' => ['path', 'to', 'subdir'],
 );

 # Relative path to file1.
 print $obj->file('file1')->s."\n";

 # Relative path to file2.
 print $obj->file('file2')->s."\n";

 # Output:
 # path/to/subdir/file1
 # path/to/subdir/file2

=head1 EXAMPLE4

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use File::Object;

 # Object with directory path.
 my $obj = File::Object->new(
         'dir' => ['path', 'to', 'subdir'],
 );

 # Relative path to dir1.
 print $obj->dir('dir1')->s."\n";

 # Relative path to dir2.
 print $obj->reset->dir('dir2')->s."\n";

 # Output:
 # path/to/subdir/dir1
 # path/to/subdir/dir2

=head1 DEPENDENCIES

L<Class::Utils(3pm)>,
L<Error::Pure(3pm)>,
L<FindBin(3pm)>,
L<File::Spec::Functions(3pm)>.

=head1 REPOSITORY

L<https://github.com/tupinek/File-Object>

=head1 AUTHOR

 Michal Špaček L<mailto:skim@cpan.org>
 L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

BSD license.

=head1 VERSION

0.01

=cut
