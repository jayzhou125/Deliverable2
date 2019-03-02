require_relative 'prospector.rb'
require_relative 'location.rb'

# array of location names
@l_name = ['Enumerable Canyon', 'Duck Type Beach', 'Monkey Patch City',
           'Nil Town', 'Matzburg', 'Hash Crossing', 'Dynamic Palisades']

# set up the lacation map
def set_map
  @ec = Location.new(@l_name[0], [@dtb, @mpc], 1, 1)
  @dtb = Location.new(@l_name[1], [@ec, @m], 2, 2)
  @mpc = Location.new(@l_name[2], [@ec, @nt, @m], 1, 1)
  @nt = Location.new(@l_name[3], [@mpc, @hc], 0, 3)
  @m = Location.new(@l_name[4], [@dtb, @mpc, @hc, @dp], 3, 0)
  @hc = Location.new(@l_name[5], [@nt, @m, @dp], 2, 2)
  @dp = Location.new(@l_name[6], [@m, @hc], 2, 2)
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
