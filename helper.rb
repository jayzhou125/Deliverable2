require_relative 'prospector.rb'
require_relative 'location.rb'
# require_relative 'helper_test'

# set up the lacation map
# argument: N/A
# return: N/A
def set_map
  create_single_locations
  construct_the_map
end

# This method create every locations of the map
# argument: N/A
# return: N/A
def create_single_locations
  @ec = Location.new('Enumerable Canyon', 1, 1)
  @dtb = Location.new('Duck Type Beach', 2, 2)
  @mpc = Location.new('Monkey Patch City', 1, 1)
  @nt = Location.new('Nil Town', 0, 3)
  @m = Location.new('Matzburg', 3, 0)
  @hc = Location.new('Hash Crossing', 2, 2)
  @dp = Location.new('Dynamic Palisades', 2, 2)
end

# This method puts together the map
# argument: N/A
# return: array of cities
def construct_the_map
  @ec.add_neighbors([@dtb, @mpc])
  @dtb.add_neighbors([@ec, @m])
  @mpc.add_neighbors([@nt, @ec, @m])
  @nt.add_neighbors([@mpc, @hc])
  @m.add_neighbors([@mpc, @dtb, @hc, @dp])
  @hc.add_neighbors([@m, @nt, @dp])
  @dp.add_neighbors([@m, @hc])
  [@ec, @dtb, @mpc, @nt, @m, @hc, @dp]
end

# This is helper method to chack the arguments
# argument: ARGV
# return: code, seed, num_of_prospectors, num_of_turns
def validates(args)
  num_check = num_check(args)
  int_check = int_check(args)
  neg_check = neg_check(args)
  return [1, nil, nil, nil] if num_check == false || int_check == false || neg_check == false

  [0, args[0].to_i, args[1].to_i, args[2].to_i]
end

# helper method checking commandline arguments
# argument: argument
# return: boolean
def num_check(args)
  return false if args.length != 3
end

# helper method checking commandline arguments
# argument: argument
# return: boolean
def int_check(args)
  args.each { |i| Integer(i) }
rescue StandardError
  false
end

# helper method checking commandline arguments
# argument: argument
# return: boolean
def neg_check(args)
  return false if args[1].to_i < 0 || args[2].to_i < 0
end

# helper method print out a usage message and exit
# argument: N/A
# return: N/A
def print_usage
  puts 'Usage:
ruby ruby_rush.rb *seed* *num_prospectors* *num_turns*
*seed* should be an integer
*num_prospectors* should be a non-negative integer
*num_turns* should be a non-negative integer'
end
