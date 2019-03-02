require_relative 'prospector.rb'
require_relative 'location.rb'

# set up the lacation map
def set_map
  create_single_locations
  construct_the_map
end

# This method create every locations of the map
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
def validates(args)
  num_check = num_check(args)
  int_check = int_check(args)
  neg_check = neg_check(args)
  return [1, 1, 1, 1] if num_check == false || int_check == false || neg_check == false

  [0, args[2].to_i, args[2].to_i, args[2].to_i]
end

# check commandline arguments
def num_check(args)
  return false if args.length != 3
end

# check commandline arguments
def int_check(args)
  args.each { |i| Integer(i) }
rescue StandardError
  false
end

# check commandline arguments
def neg_check(args)
  return false if args[1].to_i < 0 || args[2].to_i < 0
end

# print out a usage message and exit
def print_usage
  puts 'Usage:
ruby ruby_rush.rb *seed* *num_prospectors* *num_turns*
*seed* should be an integer
*num_prospectors* should be a non-negative integer
*num_turns* should be a non-negative integer'
end
