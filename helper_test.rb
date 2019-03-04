# Note that we require and start simplecov before
# doing ANYTHING else, including other require statements.
require 'simplecov'
require_relative 'helper'

# This is the test class for helper.rb
class Helpertest < Minitest::Test
  # This suit test the initialize of the lacation map
  # method include: set_up, create_single_locations, construct_the_map
  #
  # UNIT TESTS FOR METHOD set_up
  # expect :create_single_locations
  # expect :construct_the map
  def test_set_map
    set_map
    assert expect: create_single_locations
    assert expect: construct_the_map
  end

  # UNIT TESTS FOR METHOD create_single_locations
  # verify every location

  # UNIT TESTS FOR METHOD construct_the_map
  # verify the return value

  # This suit test validates method
  # UNIT TESTS FOR num_check(args)
  # Equivalence classes:
  # args = [] --> false
  # args = [1] --> false
  # args = [1, 1] --> false
  # args = [1, 1, 1] --> nil
  # args.size > 3 --> false
  def test_num_check
    assert_equal num_check([]), false # pass
    assert_equal num_check(['1']), false # pass
    assert_equal num_check(['1', '1']), false # pass
    assert_equal num_check(['1', '1', '1']), nil # pass
    assert_equal num_check(['k', 'k', 'k']), nil # pass
    assert_equal num_check(['k', 'k', 'k', 'k']), false # pass
  end

  # UNIT TESTS FOR int_check(args)
  # Equivalence classes:
  # args = [] --> false (EDGE CASE)
  # args = [1, 1, 1] --> nil
  # args = [a, s, d, f] --> false
  # args = [1, 2, 3, 4, 5] --> nil
  # def test_int_check
  #   assert_equal int_check([]), [] # pass
  #   assert_equal int_check(['%1']), false # pass
  #   assert_equal int_check(['%1', '%1']), false # pass
  #   assert_equal int_check(['%1', '%1', '%1']), false # pass
  #   assert_equal int_check(['%k', '%k', '%k']), false # pass
  #   assert_equal int_check(['%a', '%s', '%d', '%f']), false # pass
  # end

  # UNIT TESTS FOR neg_check(args)
  # Equivalence classes:
  # args = [0, -1, 0] --> false
  # args = [0, 0, -1] --> false
  # args = [0, -9, -9] --> false
  # args = [0, 0, 0] --> nil(means pass)
  # args = [0, 2, 3] --> nil(means pass)
  # This tests when argument contain negative in the [1] or [2] index
  def test_neg_check_fail
    assert_equal neg_check(['0', '-1', '0']), false # return false
    assert_equal neg_check(['0', '0', '-1']), false # return false
    assert_equal neg_check(['0', '-9', '-9']), false # return false
  end

  # This tests when argument contain no negative in the [1] or [2] index
  def test_neg_check_success
    assert_equal neg_check(['0', '0', '0']), nil # pass
    assert_equal neg_check(['0', '2', '3']), nil # pass
  end

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
  # This test when argument is not as required
  def test_validates_fail
    assert_equal validates(['1']), [1, nil, nil, nil] # return 1
    assert_equal validates(['1', '1']), [1, nil, nil, nil] # return 1
    assert_equal validates(['k', '1', '6']), [1, nil, nil, nil] # return 1
    assert_equal validates(['1', '-1', '1']), [1, nil, nil, nil] # return 1
    assert_equal validates(['-19', '4', '-1']), [1, nil, nil, nil] # return 1    
  end

  # This test when argument is as required
  def test_validates_success
    assert_equal validates(['2', '2', '2']), [0, 2, 2, 2] # pass
    assert_equal validates(['-16', '4', '2']), [0, -16, 4, 2] # pass
  end

  # UNIT TEST FOR print_usage
  # compare the output
  def test_print_usage
    assert_output('Usage:
ruby ruby_rush.rb *seed* *num_prospectors* *num_turns*
*seed* should be an integer
*num_prospectors* should be a non-negative integer
*num_turns* should be a non-negative integer') { print_usage }
  end
end
