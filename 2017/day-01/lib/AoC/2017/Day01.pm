use strict;
use warnings;

package AoC::2017::Day01;

sub inverse_captcha {
    my ($input) = @_;

    # empty string or non-digit characters
    return -1 if ( length($input) == 0 ) || ( $input =~ m{\D} );

    my $digits = [ map int, split '', $input ];

    # single digits results in itself
    return $digits->[0] if @{$digits} == 1;

    my $sum = 0;
    _inverse_captcha( \$sum, $digits, 0, $#{$digits} );

    return $sum;

}

sub _inverse_captcha {
    my ( $sum_ref, $digits, $index, $last_index ) = @_;

    if ( $index < $last_index ) {
        if ( $digits->[$index] == $digits->[ $index + 1 ] ) {
            ${$sum_ref} += $digits->[$index];
        }
        _inverse_captcha( $sum_ref, $digits, $index + 1, $last_index );
    }
    else {
        # $index == $last_index
        if ( $digits->[$index] == $digits->[0] ) {
            ${$sum_ref} += $digits->[$index];
        }
    }
}

'true';
