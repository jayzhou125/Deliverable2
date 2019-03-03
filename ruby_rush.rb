require_relative 'prospector.rb'
require_relative 'location.rb'
require_relative 'helper.rb'

location = set_map
exit_code, seed, num_of_prospectors, num_of_turns = validates(ARGV)
if exit_code.zero? # if code is exit_code is 0
  rng = Random.new(seed) # make a random number generator
  (1..num_of_prospectors).each do |number|
    ruby_digger = Prospector.new(number, num_of_turns, rng)
    ruby_digger.ruby_rush(location[0]) # always start with the same location
  end
else
  print_usage
  exit(exit_code) # exit with code 1
end
