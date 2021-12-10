#!/usr/bin/env ruby
require('pry')
INPUT_FILE = 'input.txt'


def get_adjacent_coords(x, y, grid)
    up = [x, y-1]
    down = [x, y+1]
    left = [x-1, y]
    right = [x+1, y]    

    adjacent_coords = [up, down, left, right].reject do |point|        
        point.first < 0 || point.last < 0 || point.last >= grid.first.size || point.first >= grid.size
    end

    return adjacent_coords
end

def get_adjacent_points(adjacent_coords, grid)
    return adjacent_coords.map do |coords|
        grid[coords.first][coords.last]        
    end
end

def is_low_point?(x, y, grid)
    coords = get_adjacent_coords(x, y, grid)
    points = get_adjacent_points(coords, grid)
    return points.all? { |point| point > grid[x][y] }
end

def initialize_grid(lines)
    grid = Array.new(lines.first.size) { |i| [] }
    grid.map do |row|
        (lines.size-1).times do |i|
            row.push(0)
        end
    end    
    lines = lines
        .map { |line| line.split("") }
        .map do |line|
            line.map(&:to_i)
        end
        .each_with_index do |line, i|
            line.each_with_index do |num, j|                
                grid[j][i] = num
            end
        end    
    return grid
end

file = File.open(INPUT_FILE)
file_data = file.readlines.map(&:chomp)
grid = initialize_grid(file_data)

risk_level_sum = 0

grid.each_with_index do |row, x|    
    row.each_with_index do |col, y|        
        # adjacent_coords = get_adjacent_coords(x, y, grid)
        # adjacent_points = get_adjacent_points(adjacent_coords, grid)
        if (is_low_point?(x,y,grid))
            risk_level_sum += (grid[x][y]+1)
            puts "Point (#{x}, #{y}) -> #{grid[x][y]}, risk level #{grid[x][y]+1}"
        end
    end
end

puts "Total risk level: #{risk_level_sum}"