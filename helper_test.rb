# Note that we require and start simplecov before
# doing ANYTHING else, including other require statements.
require 'simplecov'
SimpleCov.start

# Previous code starts here!

require 'minitest/autorun'

require_relative 'ruby' # 不能加ruby_rush

# This is the test class for ruby_rush
class RubyRushTest < Minitest::Test
  # This suit is going to test the check_args
  # this test the number of args
  def num_of_arg_test
    ARGV[0] = 0
    check_num_of_args
    assert_output('Usage:
                  ruby ruby_rush.rb *seed* *num_prospectors* *num_turns*
                  *seed* should be an integer
                  *num_prospectors* should be a non-negative integer
                  *num_turns* should be a non-negative integer') { check_num_of_args }
  end

  # This test the negative args
  def negative_arg_test
    assert_output('Usage:
                  ruby ruby_rush.rb *seed* *num_prospectors* *num_turns*
                  *seed* should be an integer
                  *num_prospectors* should be a non-negative integer
                  *num_turns* should be a non-negative integer') 
                  { check_negative_args([-1, -1, -1]) }
  end
end
