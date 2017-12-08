use strict;
use warnings;

package AoC::2017::Day05;

sub twisty_trampolines {
    my ($jumps) = @_;

    my $steps = 0;
    _twisty_trampolines( $jumps, 0, $#{$jumps}, \$steps );
    return $steps;
}

sub _twisty_trampolines {
    my ( $jumps, $index, $last_index, $steps ) = @_;

    my $jump = $jumps->[$index];
    $jumps->[$index] += 1;
    ${$steps} += 1;

    return if $index + $jump > $last_index;

    # goto FTW
    @_ = ( $jumps, $index + $jump, $last_index, $steps );
    goto &_twisty_trampolines;

}

'ok';
