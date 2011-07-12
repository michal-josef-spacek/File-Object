package File::Object;

# Pragmas.
use strict;
use warnings;

# Modules.
use Class::Utils qw(set_params);
use Error::Pure qw(err);
use FindBin qw($Bin $Script);
use File::Spec::Functions qw(catdir catfile rel2abs splitdir);

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

	# Path initialization.
	$self->_init;

	# Object.
	return $self;
}

# Add dir.
sub dir {
	my ($self, @dirs) = @_;
	# XXX Is this right?
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
	# XXX is this right?
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

# Initialization.
sub _init {
	my $self = shift;
	if ($self->{'type'} eq 'file') {
		if ($self->{'file'}) {
			$self->{'path'} = [@{$self->{'dir'}}, $self->{'file'}];
		} else {
			my $file_abs_path = rel2abs($Script);
			$self->{'path'} = [splitdir($file_abs_path)];
		}
	} else {
		if (@{$self->{'dir'}}) {
			$self->{'path'} = $self->{'dir'};
		} else {
			$self->{'path'} = [splitdir($Bin)];
		}
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

=item C<dir(@dir)>

TODO

=item C<file(@file)>

TODO

=item C<get_dir($dir_num)>

TODO

=item C<get_file()>

TODO

=item C<s()>

 Serialize path and return.

=item C<up($up_num)>

TODO

=back

=head1 ERRORS

 Mine:
         'dir' parameter must be a reference to array.
         Bad 'type' parameter.
         Cannot go up.
                 PATH -> path;

 From Class::Utils::set_params():
         Unknown parameter '%s'.

=head1 DEPENDENCIES

L<Class::Utils(3pm)>,
L<Error::Pure(3pm)>,
L<FindBin(3pm)>,
L<File::Spec::Functions(3pm)>.

=head1 AUTHOR

 Michal Špaček L<skim@cpan.org>
 http://skim.cz

=head1 LICENSE AND COPYRIGHT

BSD license.

=head1 VERSION

0.01

=cut
