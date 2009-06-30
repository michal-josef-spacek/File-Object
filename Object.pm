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
	$self->{'type'} = 'file';

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

	my $self = shift;
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
	return $self;
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

=back

=head1 ERRORS

 Mine:
   TODO

 From File::Object::Utils::set_params():
   Unknown parameter '%s'.

=head1 DEPENDENCIES

 TODO

=head1 SEE ALSO

 TODO

=head1 AUTHOR

Michal Špaček L<tupinek@gmail.com>

=head1 LICENSE AND COPYRIGHT

BSD license.

=head1 VERSION

0.01

=cut
