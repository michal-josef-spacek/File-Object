#------------------------------------------------------------------------------
package File::Object;
#------------------------------------------------------------------------------

# Pragmas.
use strict;
use warnings;

# Modules.
use Error::Simple::Multiple qw(err);
use FindBin qw($Bin $Script);
use File::Spec::Functions qw(catfile rel2abs splitdir);
use File::Object::Utils qw(set_params);

# Version.
our $VERSION = 0.01;

#------------------------------------------------------------------------------
sub new {
#------------------------------------------------------------------------------
# Constructor.

	my ($class, @params) = @_;
	my $self = bless {}, $class;

	# Dir path.
	$self->{'dir'} = undef;

	# File path.
	$self->{'file'} = undef;

	# Type of path.
	$self->{'type'} = 'dir';

	# Process parameters.
	set_params($self, @params);

	# Check to right 'type'.
	if (! $self->{'type'} || ($self->{'type'} ne 'file' 
		&& $self->{'type'} ne 'dir')) {

		err "Bad 'type' parameter.";
	}

	# Path.
	if ($self->{'type'} eq 'file') {
		if ($self->{'file'}) {
			$self->{'path'} = [splitdir($self->{'file'})];
		} else {
			my $file_abs_path = rel2abs($Script);
			$self->{'path'} = [splitdir($file_abs_path)];
		}
	} else {
		if ($self->{'dir'}) {
			$self->{'path'} = [splitdir($self->{'dir'})];
		} else {
			$self->{'path'} = [splitdir($Bin)];
		}
	}

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub dir {
#------------------------------------------------------------------------------
# Add dir.

	my ($self, $dir) = @_;
	$self->_dir([$dir]);

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub dir_path {
#------------------------------------------------------------------------------
# Add dir path.

	my ($self, $dir_path) = @_;

	# Split to parts.
	my @parts = splitdir($dir_path);

	# Add to path.
	$self->_dir(\@parts);

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub file {
#------------------------------------------------------------------------------
# Add file.

	my ($self, $file) = @_;
	$self->_file([$file]);

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub file_path {
#------------------------------------------------------------------------------
# Add file path.

	my ($self, $file_path) = @_;
	
	# Split to parts.
	my @file = splitdir($file_path);

	# Add to path.
	$self->_file(\@file);

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
sub serialize {
#------------------------------------------------------------------------------
# Serialize path.

	my $self = shift;
	return catfile(@{$self->{'path'}});
}

#------------------------------------------------------------------------------
sub up {
#------------------------------------------------------------------------------
# Go to parent directory.

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
				err 'Cannot go up.', 'PATH', $self->serialize;
			}
		} else {
			if (@{$self->{'path'}}) {
				pop @{$self->{'path'}};
			} else {
				err 'Cannot go up.', 'PATH', $self->serialize;
			}
		}
	}

	# Object.
	return $self;
}

#------------------------------------------------------------------------------
# Internal subroutines.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
sub _dir {
#------------------------------------------------------------------------------
# Add dir array.

	my ($self, $dir_ar) = @_;	
	if ($self->{'type'} eq 'file') {
		$self->{'type'} = 'dir';
		pop @{$self->{'path'}};
	}
	push @{$self->{'path'}}, @{$dir_ar};
	return;
}

#------------------------------------------------------------------------------
sub _file {
#------------------------------------------------------------------------------
# Add file array.

	my ($self, $file_ar) = @_;
	if ($self->{'type'} eq 'file') {
		pop @{$self->{'path'}};
		push @{$self->{'path'}}, @{$file_ar};
	} else {
		push @{$self->{'path'}}, @{$file_ar};
		$self->{'type'} = 'file';
	}
	return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

File::Object - TODO

=head1 SYNOPSIS

 TODO

=head1 METHODS

=over 8

=item C<new()>

Constructor.

=over 8

=item * C<dir>

TODO

=item * C<file>

TODO

=item * C<type>

TODO

=back

=item C<dir($dir)>

TODO

=item C<dir_path($dir_path)>

TODO

=item C<file($file)>

TODO

=item C<file_path($file_path)>

TODO

=item C<serialize()>

TODO

=item C<up($up_num)>

TODO

=back

=head1 ERRORS

 Mine:
   Bad 'type' parameter.
   Cannot go up.
     PATH -> path;

 From File::Object::Utils::set_params():
   Unknown parameter '%s'.

=head1 DEPENDENCIES

L<Error::Simple::Multiple(3pm)>,
L<FindBin(3pm)>,
L<File::Spec::Functions(3pm)>,
L<File::Object::Utils(3pm)>.

=head1 SEE ALSO

 TODO

=head1 AUTHOR

Michal Špaček L<tupinek@gmail.com>

=head1 LICENSE AND COPYRIGHT

BSD license.

=head1 VERSION

0.01

=cut
