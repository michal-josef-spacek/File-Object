package File::Object;

# Pragmas.
use strict;
use warnings;

# Modules.
use Error::Simple::Multiple qw(err);
use FindBin qw($Bin $Script);
use File::Spec::Functions qw(catdir catfile rel2abs splitdir);
use File::Object::Utils qw(set_params);

# Version.
our $VERSION = 0.01;

# Constructor.
sub new {
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

# Add dir.
sub dir {
	my ($self, $dir) = @_;

	# Only if is $dir defined.
	if (defined $dir) {
		$self->_dir([$dir]);
	}

	# Object.
	return $self;
}

# Add dir path.
sub dir_path {
	my ($self, $dir_path) = @_;

	# Only if is $dir_path defined.
	if (defined $dir_path) {

		# Split to parts.
		my @parts = splitdir($dir_path);

		# Add to path.
		$self->_dir(\@parts);
	}

	# Object.
	return $self;
}

# Add file.
sub file {
	my ($self, $file) = @_;

	# Only if is $file defined.
	if (defined $file) {
		$self->_file([$file]);
	}

	# Object.
	return $self;
}

# Add file path.
sub file_path {
	my ($self, $file_path) = @_;

	# Only if is $file_path defined.
	if (defined $file_path) {	

		# Split to parts.
		my @file = splitdir($file_path);

		# Add to path.
		$self->_file(\@file);
	}

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

# Serialize path.
sub serialize {
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

# Add dir array.
sub _dir {
	my ($self, $dir_ar) = @_;	
	if ($self->{'type'} eq 'file') {
		$self->{'type'} = 'dir';
		pop @{$self->{'path'}};
	}
	push @{$self->{'path'}}, @{$dir_ar};
	return;
}

# Add file array.
sub _file {
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

=item C<dir($dir)>

TODO

=item C<dir_path($dir_path)>

TODO

=item C<file($file)>

TODO

=item C<file_path($file_path)>

TODO

=item C<get_dir($dir_num)>

TODO

=item C<get_file()>

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
