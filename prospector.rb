# This is a prospector class
class Prospector
  attr_accessor :Location, :num_ruby_found, :num_of_turns, :prng
  def initialize(number, num_of_turns, rng)
    @number = number
    @num_of_turns = num_of_turns
    @rng = rng
    @day = 0
    @total_ruby_found = [0, 0]
  end

  # This print out the number of pros and the starting point
  # argument: number
  # return: N/A
  def print_start(number)
    puts "Rubyist \##{number} starting in Enumerable Canyon."
  end

  # This show the ruby or rubies found in the current location
  # argument: current_found
  # return: N/A
  def print_ruby_found_in_this_location(current_location, current_found)
    real = current_found[0]
    fake = current_found[1]
    if real.zero? && fake.zero?
      puts "        Found no rubies or fake rubies in #{current_location.name}."
    elsif fake.zero?
      puts "        Found #{real} #{plural?(real)} in #{current_location.name}."
    elsif real.zero?
      puts "        Found #{fake} fake #{plural?(fake)} in #{current_location.name}."
    else
      puts "        Found #{real} #{plural?(real)} and #{fake} fake #{plural?(fake)} in #{current_location.name}."
    end
  end

  # THis is to print the heading
  # argument: previous_location, current_locaiton
  # return: N/A
  def print_heading(p_location, c_location)
    puts "Heading from #{p_location} to #{c_location}"
  end

  # This method decides whether use plural
  def plural?(num)
    return 'ruby' if num == 1
    return 'rubies' if num > 1
  end

  # This determine the mood of the rubyist
  # argument: total_ruby_found
  # return mood
  def mood?(total_ruby_found)
    total_real = total_ruby_found[0]
    return 'victorious!' if total_real > 10
    return 'sad.' if total_real >= 1 && total_real <= 9
    return 'empty-handed.' if total_real.zero?
  end

  # This method shows the reault of a rush
  # argument: day, number, total_ruby_found
  # return: N/A
  def show_rush_result(day, number, total_ruby_found)
    puts "After #{day} days, Rubyist #{number} found:
        #{total_ruby_found[0]} rubies.
        #{total_ruby_found[1]} fake rubies.
Going home #{mood?(total_ruby_found)}"
  end

  # This is the dig method
  # argument: location, rng
  # return: true after finished digging
  def dig(current_locaiton, rng)
    current_found = []
    while current_found != [0, 0]
      current_found = current_locaiton.random_total_ruby(rng) # digging
      @day += 1
      @total_ruby_found[0] += current_found[0] # add up the real ruby
      @total_ruby_found[1] += current_found[1] # add up the fake ruby
      print_ruby_found_in_this_location(current_locaiton, current_found)
    end
    true
  end

  # This is the actual method where prospector do the rush
  def ruby_rush(current_locaiton)
    print_start(@number)
    if @num_of_turns > 1
      while num_of_turns != 0 # keep the count of turns
        done_with_current = dig(current_locaiton, @rng) # return whether finished with the current location
        if done_with_current == true # if done with the current location
          @num_of_turns -= 1 # update the count
          previous_location = current_locaiton.name
          current_locaiton = current_locaiton.go_to_next(@rng) # go to next location
          print_heading(previous_location, current_locaiton.name) # print heading from and to
        end
      end
      show_rush_result(@day, @number, @total_ruby_found) # print the result of rubyist rush
    else
      done = dig(current_locaiton, @rng) # return whether finished with the current location
      show_rush_result(@day, @number, @total_ruby_found) if done # print the result of rubyist rush
    end
  end
end
