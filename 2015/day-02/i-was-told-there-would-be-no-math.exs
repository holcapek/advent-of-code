defmodule AdventOfCode2015Day02 do
    def _slack(dim) do
        [ a, b ] = dim
        |> Enum.sort
        |> Enum.take(2)
        a * b 
    end

    def wrapping_paper(dim) do
       { length, width, height } = dim
       slack = _slack( [ length, width, height ] )
       2*length*width + 2*width*height + 2*height*length + slack
    end

    def _string_dim_to_int_tuple(str) do
        str
        |> String.split("x")
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple
    end
end

test_input_1  = [ "2x3x4", "1x1x10" ]
test_output_1 = [ 58,      43 ]

true = test_output_1 ==
        test_input_1
        |> Enum.map(&AdventOfCode2015Day02._string_dim_to_int_tuple/1)
        |> Enum.map(&AdventOfCode2015Day02.wrapping_paper/1)

puzzle = File.read!("puzzle.input")
    |> String.split
    |> Enum.map(&AdventOfCode2015Day02._string_dim_to_int_tuple/1)

true = 1606483 == 
    puzzle
    |> Enum.map(&AdventOfCode2015Day02.wrapping_paper/1)
    |> Enum.sum
