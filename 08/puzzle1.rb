#!/usr/bin/env ruby

require('pry')
INPUT_FILE = "input.txt"

file = File.open(INPUT_FILE)
file_data = file.readlines

segments = []

display = file_data
    .map { |line| line.split(" | ") }
    .map { |line| line.map(&:chomp) }
    .map { |line| line.last  }
    .map { |output| output.split(" ") }

display.each do |output|
    output.each do |digit|
        if digit.size == 2 || digit.size == 4 || digit.size == 3 || digit.size == 7
            segments.push(digit)
        end  
    end
end

puts "segments: #{segments.size}"