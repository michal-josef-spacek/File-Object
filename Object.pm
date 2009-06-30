#------------------------------------------------------------------------------
package File::Object;
#------------------------------------------------------------------------------

# Pragmas.
use strict;
use warnings;

# Modules.
use Error::Simple::Multiple qw(err);
use FindBin qw($Bin);
use File::Spec::Functions qw(catfile splitpath);
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

	# Process parameters.
	set_params($self, @params);

	# Check to 'dir' and 'file'.
	if (defined $self->{'dir'} && defined $self->{'file'}) {
		err 'Cannot use \'dir\' parameter and \'file\' parameter '.
			'at the same time.';
	}

	# Path.
	if ($self->{'dir'}) {
		$self->{'path'} = splitdir($self->{'dir'});
	} elsif ($self->{'file'}) {
		$self->{'path'} = splitpath($self->{'file'});
	} else {
		$self->{'path'} = splitdir($Bin);
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
