use strict;
use warnings;

package AoC::2017::Day01;

sub inverse_captcha {
    my ($input) = @_;

    my $digits = _check_input($input);
    return $digits unless ref $digits;

    my $sum = _inverse_captcha( $digits, sub { $_[0] + 1 } );

    return $sum;

}

sub inverse_captcha_2 {
    my ($input) = @_;

    my $digits = _check_input($input);
    return $digits unless ref $digits;

    my $sum = _inverse_captcha( $digits, sub { $_[0] + int( @{$digits} / 2 ) } );

    return $sum;

}

sub _check_input {
    my ($input) = @_;

    # empty string or non-digit characters
    return -1 if ( length($input) == 0 ) || ( $input =~ m{\D} );

    my $digits = [ map int, split '', $input ];

    # single digits results in itself
    return $digits->[0] if @{$digits} == 1;

    return $digits;

}

sub _inverse_captcha {
    my ( $digits, $second_index_coderef ) = @_;

    my $sum = 0;

    foreach my $index ( 0 .. $#{$digits} ) {
        my $second_index = $second_index_coderef->($index) % @{$digits};
        $sum += _sum_if_match( $digits, $index, $second_index );
    }

    return $sum;
}

sub _sum_if_match {
    my ( $digits, $index, $second_index ) = @_;

    return $digits->[$index] if $digits->[$index] == $digits->[$second_index];
    return 0;
}

'true';
