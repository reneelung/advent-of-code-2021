#!/usr/bin/env ruby
require 'pry'

# initialize fish with timers
# count number of initial fish
# for each day
#   Count the number of zeros, this will be the number of new fish
#   Decrement each timer by 1, if result is < 1, set it to 6
#   Add new fish

INPUT_FILE = "input.txt"
NEW_FISH_TIMER_START = 8
FISH_TIMER_START = 6
DAYS = 80

def do_fish
    file = File.read(INPUT_FILE)

    fishes = file.split(',').map(&:to_i)    
    (1..DAYS).each do |day|
        # puts "Beginning of Day #{day} fishes: #{fishes.inspect}" 
        fish_to_spawn = 0
        fishes = fishes                
                .each do |timer|
                    if timer == 0
                        fish_to_spawn = fish_to_spawn + 1
                    end
                end            
                .map do |timer|                                  
                    timer = timer-1                    
                end
                .map.with_index do |timer, index|
                    # puts "Fish #{index} timer: #{timer}"
                    if (timer < 0)
                        timer = 6
                    else
                        timer = timer
                    end
                end
                # .each_with_index do |timer, index|
                #     puts "Fish #{index} timer: #{timer}"
                # end
        # puts "Fish: #{fishes.inspect}"
        puts "Spawning #{fish_to_spawn} fish..."
        fishes = spawn_fishes(fishes, fish_to_spawn)
        puts "After #{day} days: #{fishes.size} fish"    
        puts "*************************\n"
    end
end

def spawn_fishes(school, num_new_fish)
    num_new_fish.times { |i| school << NEW_FISH_TIMER_START }
    return school
end

def reset_fish(school)

end

do_fish