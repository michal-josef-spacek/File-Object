#!/usr/bin/env perl

# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;

# Print actual directory path.
print File::Object->new->s."\n";