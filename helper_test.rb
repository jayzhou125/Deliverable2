# Note that we require and start simplecov before
# doing ANYTHING else, including other require statements.
require 'simplecov'

# Previous code starts here!

require 'minitest/autorun'

require_relative 'helper.rb'
require_relative 'location.rb'

# This is the test class for helper.rb
class Helpertest < Minitest::Test
  # This suit test the initialize of the lacation map
  # method include: set_up, create_single_locations, construct_the_map
  #
  # UNIT TESTS FOR METHOD set_up
  # expect :create_single_locations
  # expect :construct_the map
  # ..............

  # UNIT TESTS FOR METHOD create_single_locations
  # verify every location

  # UNIT TESTS FOR METHOD construct_the_map
  # verify the return value

  # This suit test validates method
  # UNIT TESTS FOR num_check(args)
  # Equivalence classes:
  # args = [] --> false
  # args = [k] --> false
  # args = [k, k] --> false
  # args = [k, k, ,k] --> nothing(means pass)
  # args.size > 3 --> false
  def arg_empty_test
    assert(false) { num_check([]) } # pass
  end

  def arg_

  # UNIT TESTS FOR int_check(args)
  # Equivalence classes:
  # args = [] --> false (EDGE CASE)
  # args = [a, s, d, f, g] --> false
  # args = [1, 2, 3, 4, 5] --> nothing(means pass)

  # UNIT TESTS FOR neg_check(args)
  # Equivalence classes:
  # args = [0, -1, 0] --> false
  # args = [0, 0, -1] --> false
  # args = [0, -9, -9] --> false
  # args = [0, 0, 0] --> nothing(means pass)
  # args = [0, 2, 3] --> nothing(means pass)

  # UNIT TESTS FOR validates(args)
  # SUCCESS CASES: args.size == 3, all elements are integer, args[1] & args[2] are non-negtive
  # FAILURE CASES: any one of the three conditions return false
  # Equivalence classes:
  # args = [1] --> [1, nil, nil, nil]
  # args = [1, 1] --> [1, nil, nil, nil]
  # args = [k, 1, 6] --> [1, nil, nil, nil]
  # args = [1, -1, 1] --> [1, nil, nil, nil]
  # args = [-19, 4, -1] --> [1, nil, nil, nil]
  # args = [2, 2, 2] --> [0, 2, 2, 2]
  # args = [-16, 4, 2] --> [0, -16, 4, 2]

  # UNIT TEST FOR print_usage
  # compare the output
  def print_usage_test
    assert_output('Usage:
ruby ruby_rush.rb *seed* *num_prospectors* *num_turns*
*seed* should be an integer
*num_prospectors* should be a non-negative integer
*num_turns* should be a non-negative integer') { print_usage }
  end
end
