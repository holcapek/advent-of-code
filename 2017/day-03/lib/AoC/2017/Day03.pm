use strict;
use warnings;

package AoC::2017::Day03;

sub manhattan_distance {
    my ($num) = @_;

    return 0 if $num == 1;

    my ( $layer, $quadrant, $segment_max ) = _layer_quadrant_segment_max($num);

    my $steps = $layer;

    if ($quadrant) {    # left-up
        my $steps_right = int( sqrt($segment_max) / 2 );
        my $steps_down  = $steps_right;
        my $segment_mid = $segment_max - int( sqrt($segment_max) - 1 );

        my $up_axis   = $segment_max - $steps_right;
        my $left_axis = $segment_mid - $steps_down;

        if ( $num > $segment_mid ) {
            $steps += abs( $up_axis - $num );
        }
        else {
            $steps += abs( $left_axis - $num );
        }

    }
    else {    # right-down
        my $steps_left  = int( sqrt($segment_max) / 2 - 1 );
        my $steps_up    = $steps_left + 1;
        my $segment_mid = $segment_max - int( sqrt($segment_max) - 1 );

        my $down_axis  = $segment_max - $steps_left;
        my $right_axis = $segment_mid - $steps_up;

        if ( $num > $segment_mid ) {
            $steps += abs( $down_axis - $num );
        }
        else {
            $steps += abs( $right_axis - $num );
        }

    }

}

sub _segment_ceil {
    my ($num) = @_;
    my $sqrt_floor = int sqrt $num;
    return ( $sqrt_floor + 1 )**2 if ( $sqrt_floor**2 ) < $num;
    return $sqrt_floor**2;
}

sub _layer_quadrant_segment_max {
    my ($num) = @_;

    # $num == 1 is checked in the main sub

    my $segment_max = _segment_ceil($num);
    my $layer       = int( sqrt($segment_max) / 2 );
    my $quadrant    = $segment_max % 2;

    # $quadrant = 0 -> right-down
    # $quadrant = 1 -> left-up
    return $layer, $quadrant, $segment_max;

}

'ok';
