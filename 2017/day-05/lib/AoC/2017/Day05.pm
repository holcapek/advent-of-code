use strict;
use warnings;

package AoC::2017::Day05;

sub twisty_trampolines {
    my ($jumps) = @_;

    my $steps = 0;
    _twisty_trampolines( $jumps, 0, $#{$jumps}, \$steps, sub { $_[0] + 1 } );
    return $steps;
}

sub twisty_trampolines_2 {
    my ($jumps) = @_;

    my $steps = 0;
    _twisty_trampolines( $jumps, 0, $#{$jumps}, \$steps,
        sub { my ( $val, $offset ) = @_; return $offset > 2 ? $val - 1 : $val + 1; } );
    return $steps;
}

sub _twisty_trampolines {
    my ( $jumps, $index, $last_index, $steps, $inc_code_ref ) = @_;

    my $jump = $jumps->[$index];
    $jumps->[$index] = $inc_code_ref->( $jumps->[$index], $jump );
    ${$steps} += 1;

    return if $index + $jump > $last_index;

    # goto FTW
    @_ = ( $jumps, $index + $jump, $last_index, $steps, $inc_code_ref );
    goto &_twisty_trampolines;

}

'ok';
