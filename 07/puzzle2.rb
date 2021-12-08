#!/usr/bin/env ruby

# minimize sum of absolute differences
require('pry')
INPUT_FILE = "input.txt"

def range_list(range_start, range_end)
    if range_start > range_end
        return (range_end..range_start).to_a.reverse
    else
        return (range_start..range_end).to_a
    end
end

file = File.read(INPUT_FILE)
positions = file.split(',').map(&:to_i).sort()

mean = (positions.sum/positions.size.to_f)
puts "Mean: #{mean}"

optimal_range = range_list(mean.floor, mean.ceil)
potential_fuel_consumed = []
# calculate fuel consumption
# fuel consumption = sum of numbers between 0 and abs val of distance traveled

optimal_range.each do |potential_position|
    fuel_consumed = 0
    positions.each do |pos|
        distance = (pos-potential_position).abs
        fuel = (1..distance).to_a.sum
        fuel_consumed += fuel        
    end
    potential_fuel_consumed.push(fuel_consumed)
end

puts "sum: #{potential_fuel_consumed.min}"
