#!/usr/bin/env ruby
require 'pry'

INPUT_FILE = "input.txt"

def generate_boards()
    file = File.open(INPUT_FILE)
    file_data = file.readlines

    draw_numbers = file_data.shift

    boards = file_data.join()
            .split("\n\n")
            .map do |board| 
                    board.split("\n").reject { |el| el.empty? }
                end
            .map do |board|
                board.map do |line|
                    line.gsub(/  /, " ").split(" ").map(&:to_i)
                end  
            end
            .map do |board|
                {
                    rows: format_rows(board),
                    columns: generate_columns(board),
                    all_numbers: board.flatten,
                    sum_of_all_numbers: board.flatten.sum
                }
            end

    return boards
end

def format_rows(rows)    
    return rows
end

def generate_columns(rows)
    columns = Array.new(rows.size) { Array.new }
    rows.each do |row|
        row.each_with_index do |num, column_number|
            columns[column_number].push(num)
        end
    end
    return columns
end

def play_bingo
    boards = generate_boards

    bingo_numbers = File.open(INPUT_FILE, &:readline).split(",").map(&:to_i)    
    no_winner = true
    winning_sum = 0
    winning_draw_number = 0
    draw_counter = 0    
    while no_winner
        drawn_number = bingo_numbers[draw_counter]            
        puts "Round #{draw_counter}, Drew number: #{drawn_number}"  
        boards.map.with_index do |board, board_num|
            if board[:all_numbers].include?(drawn_number)
                puts "Found match for #{drawn_number} in Board ##{board_num + 1}"
                board[:sum_of_all_numbers] = board[:sum_of_all_numbers] - drawn_number
            end
            board[:rows].map.with_index do |row, row_num|
                row.reject! { |row_element| row_element == drawn_number}
                puts "Board #{board_num + 1}, Row #{row_num} length: #{row.size}"
                if row.size == 0
                    puts "eliminated all numbers"
                    no_winner = false
                    winning_sum = board[:sum_of_all_numbers]
                end
            end
            board[:columns].map.with_index do |column, col_num|
                column.reject! { |column_element| column_element == drawn_number}                
                puts "Board #{board_num + 1}, Col #{col_num} length: #{column.size}"
                if column.size == 0
                    puts "eliminated all numbers"
                    no_winner = false
                    winning_sum = board[:sum_of_all_numbers]
                end            
            end
        end
        if no_winner == false
            winning_draw_number = drawn_number
        end
        draw_counter = draw_counter + 1;
        puts "******************************************************"
        puts "\n"
    end
    puts "\n"
    puts "Sum of remaining numbers on winning board: #{winning_sum}"
    puts "Winning drawn number: #{winning_draw_number}"
    puts "Answer: #{winning_draw_number*winning_sum}"
end

play_bingo

# for each board:
#   for each row, keep track of the row numbers
#   for each column, keep track of the column numbers
#   keep track of all the numbers on the board and the sum of all the numbers
# if there is no winning board:
#   draw a number
#   for each board:
#       if drawn_number is on the board, remove the number from the board and subtract it from the sum
#       for each row, 
#           check if the number is present in the row. if it is, remove from the row.
#           check if row length = 0. if it is, record the board sum and drawn number
#           record that a winning board was found
#       for each column, 
#           check if the number is present in the row. if it is, remove from the column.
#           check if the column length = 0. if it is, record the board sum and drawn number
#           record that a winning board was found
# if there is a winning board:
#   return the board sum * drawn number