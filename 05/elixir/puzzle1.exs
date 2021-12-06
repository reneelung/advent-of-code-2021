#!/usr/bin/env elixir
{:ok, contents} = File.read("testInput.txt")

data = contents |> String.split("\n", trim: true)

IO.puts("line segements: #{Kernel.inspect(data)}")

vents = Enum.map(data, fn segment ->        
        String.split(segment, " -> ") # ["x1,y1", "x2,y2"]
        |> Enum.map(fn coordinate_pair ->
            String.split(coordinate_pair, ",") # ["x1", "y1"]
        end)
        |> Enum.map(fn [x1, y1] -> 
            {String.to_integer(x1), String.to_integer(y1)} # {x1, y1}
        end)
    end)
    |> Enum.filter(fn segment ->
        [{x1, y1}, {x2, y2}] = segment
        x1 == x2 || y1 == y2
    end)
    |> Enum.map(fn [{x1, y1}, {x2, y2}] ->
        %{
            coordinates: [{x1, y1}, {x2, y2}],
            x_range: Range.new(x1, x2)|> Enum.to_list(),
            y_range: Range.new(y1, y2)|> Enum.to_list(),
        }
    end)
    # make a grid of every point
    # iterate through each vent
    # For each vent        
    #   For each entry in x range
    #       increment value in histogram at {x,y}
    #   For each entry in y range
    #       increment value in histogram at {x,y}
    # Iterate through histogram
    #   If histogram value at {x,y} > 1, increment global counter of points


    

IO.puts("vents: #{Kernel.inspect(vents)}")