#!/usr/bin/env ruby
require('pry')
INPUT_FILE = 'input.txt'

def get_all_chunks(template)
    chunks = []
    template.split("").each_with_index do |el, i|
        if ((i+1) < template.size)
            chunks.push([el, template[i+1]])
        end
    end
    return chunks
end

def get_frequency_of_letters(template_string)
    template_string.split("").each_with_object(Hash.new(0)){|key,hash| hash[key] += 1}
end
file = File.open(INPUT_FILE)
data = file.readlines.map(&:chomp).reject { |el| el.empty? }
template = data.shift
rules = {}

data = data
    .map do |el|
        el.split(" -> ")
    end
    .each do |pair|
        rules[pair.first.to_sym] = pair.last
    end

(0..39).each do |i|
    puts "Iteration #{i}..."
    new_template = []
    chunks = get_all_chunks(template)
    chunks.each_with_index do |chunk, i|
        if (i+1 == chunks.size)
            new_template.push([chunk.first, rules[chunk.join("").to_sym], chunk.last])
        else
            new_template.push([chunk.first, rules[chunk.join("").to_sym]])
        end
    end
    template = new_template.join("")
end

frequencies = get_frequency_of_letters(template).sort_by {|k,v| -v }

puts "Answer: #{frequencies.first.last-frequencies.last.last}"

