#!/usr/bin/env ruby
require 'pry'

INPUT_FILE = "../input.txt"

def map_vents
    file = File.open(INPUT_FILE)
    file_data = file.readlines        

    # Filter out the diagonal lines
    puts "Filtering out diagonal vents..."
    lines = file_data.map do |segment|
            segment.chomp.split(" -> ")
                .map do |coordinates|
                    coordinates.split(",")
                end
        end    
    # Create coordinate grid
    puts "Initializing grid..."
    grid_size = 1000
    grid = initialize_grid(grid_size)
    intersections = []

    # Determine all points along all lines
    puts "Detecting vents..."
    expanded_lines = lines.map do |line|
            x1 = line[0][0].to_i
            y1 = line[0][1].to_i
            x2 = line[1][0].to_i
            y2 = line[1][1].to_i

            x_range = range_list(x1, x2)
            y_range = range_list(y1, y2)
        
            vent_path = []                        
        
            x_index = 0
            y_index = 0
            displacement = [x_range.size, y_range.size].max

            while x_index < displacement && y_index < displacement do
                vent_path.push([x_range[x_index], y_range[y_index]])
                unless x_range.size == 1
                    x_index = x_index + 1
                end
                unless y_range.size == 1
                    y_index = y_index + 1
                end
            end        
            vent_path
        end
    
    puts "Calculating intersections..."
    expanded_lines.each do |line|            
        line.each do |point|
            x = point[0]
            y = point[1]
            grid[x][y][0] = grid[x][y][0] + 1
            intersections.push("(#{x},#{y})") if (grid[x][y].first > 1)
        end            
    end
    binding.pry
    puts "Number of intersections: #{intersections.flatten.uniq.size}"
end

def initialize_grid(grid_size)
    grid = Array.new(grid_size) { |i| [] }
    grid.map do |col|
        (1..grid_size).each do |row_num|            
            col.push([0])
        end
    end
    return grid
end
def range_list(range_start, range_end)
    if range_start > range_end
        return (range_end..range_start).to_a.reverse
    else
        return (range_start..range_end).to_a
    end
end

map_vents
 # make a grid of every point
    # iterate through each vent
    # For each vent        
    #   For each entry in x range
    #       increment value in histogram at {x,y}
    #   For each entry in y range
    #       increment value in histogram at {x,y}
    # Iterate through histogram
    #   If histogram value at {x,y} > 1, increment global counter of points
