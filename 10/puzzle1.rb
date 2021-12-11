#!/usr/bin/env ruby
require('pry')

INPUT_FILE = 'input.txt'

PUNCTUATION = {
  "(" => ")",
  "[" => "]",
  "{" => "}",
  "<" => ">"
}

CORRUPT_SCORES = {
  ")" => 3,
  "]" => 57,
  "}" => 1197,
  ">" => 25137
}

def corrupt?(bad_chars)
  bad_chars.is_a?(String)
end

def find_corrupt_char(line)
  running_chars = []
  line.each_with_index do |char, i|
    if PUNCTUATION.keys.include?(char)
      running_chars << char
    else
      last_char = running_chars.pop
      return char if last_char != PUNCTUATION.key(char)
    end
  end
  running_chars
end

syntax = File.read(INPUT_FILE).split.map { |str| str.chars }

corrupt_score = 0
line_scores = []
syntax.each_with_index do |line, i|
  error_chars = find_corrupt_char(line)
  if corrupt?(error_chars)
    corrupt_score += CORRUPT_SCORES[error_chars]
  end
end

puts "corrupt score: #{corrupt_score}"

# find valid chunks of each type of bracket remove them
# then figure out if parentheses are balanced
