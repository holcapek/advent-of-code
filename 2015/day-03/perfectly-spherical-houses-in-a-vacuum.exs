defmodule Santa do

    def steps_fold(s, { x, y, v}) do
        { nx, ny } = case s do
            "<" -> { x - 1, y }
            ">" -> { x + 1, y }
            "^" -> { x, y + 1 }
            "v" -> { x, y - 1 }
        end
        k = "#{nx}:#{ny}"
        { nx, ny, Map.update(v, k, 1, &(&1 + 1)) }
    end

    def how_many_gifted(s) do
        { _, _, v } = s 
        |> String.split("", trim: true)
        |> List.foldl({0, 0, %{ "0:0" => 1 } }, &steps_fold/2)
        
        Map.keys(v)
        |> Enum.count
    end
end

test_input = [
    "",
    ">",
    "^>v<",
    "^v^v^v^v^v"
]

test_output_1 = [
    1,
    2,
    4,
    2
]

true = test_output_1 == Enum.map(test_input, &Santa.how_many_gifted/1)

puzzle = File.read!("puzzle.input")
    |> String.split
    |> List.first


true = 2572 == Santa.how_many_gifted(puzzle)
