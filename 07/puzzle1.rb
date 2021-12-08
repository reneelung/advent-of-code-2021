#!/usr/bin/env ruby

# minimize sum of absolute differences
require('pry')
INPUT_FILE = "input.txt"

file = File.read(INPUT_FILE)
positions = file.split(',').map(&:to_i).sort()

median_index = (positions.size/2).floor

binding.pry
sum_of_differences = 0

positions.each do |pos|
    sum_of_differences += (pos-positions[median_index]).abs
end

puts "sum: #{sum_of_differences}"