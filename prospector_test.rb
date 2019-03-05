# Note that we require and start simplecov before
# doing ANYTHING else, including other require statements.
require 'simplecov'
require_relative 'prospector'

# This is the test class for prospector.rb
class ProspectorTest < Minitest::Test
  # Special method!
  # This will run the following code before each test
  # We will re-use the instance variable in each method
  # This was we don't have to type @l = Location.new(x,y,z) in each test
  def setup
    mock_rng = Minitest::Mock.new('rng')
    def mock_rng.rand(x); 1; end
    @p = Prospector.new(1, 2, mock_rng)
  end

  # UNIT TEST FOR print_start(x)
  # Equivalence classes:
  # number = nil, raise
  # number = string, raise
  # number = float, raise
  # number = int, puts
  # This is test when argument is nil
  # EDGE CASE
  def test_print_start_nil
    assert_raises(StandardError) { print_start(nil) } # pass
  end

  # This is test when argument is a string
  def test_print_start_string
    assert_raises(StandardError) { print_start('1') } # pass
  end

  # This is test when argument is a float
  def test_print_start_float
    assert_raises(StandardError) { print_start(1.2) } # pass
  end

  # This is test when argument is a int
  def test_print_start_int
    assert_output("Rubyist #1 starting in Enumerable Canyon.\n") { @p.print_start(1) } # pass
  end

  # UNIT TESTS FOR print_ruby_found_in_this_location(x, y)
  # Equivalence classes:
  # real = 0 --> only print out fake
  # fake = 0 --> only print out real
  # both not 0 --> print results
  # both 0 --> print nothing found
  # both nil --> nil (EDGE CASE)
  # This test when only found fake ruby
  def test_print_ruby_found_fake_only
    mock_location = Minitest::Mock.new('location')
    def mock_location.name; 'a'; end
    def plural?(x); 'ruby'; end
    assert_output("        Found 1 fake ruby in a.\n") {
      @p.print_ruby_found_in_this_location(mock_location, [0, 1])}
  end

  # This test when only found real ruby
  def test_print_ruby_found_real_only
    mock_location = Minitest::Mock.new('location')
    def mock_location.name; 'a'; end
    def plural?(x); 'ruby'; end
    assert_output("        Found 1 ruby in a.\n") {
      @p.print_ruby_found_in_this_location(mock_location, [1, 0])}
  end

  # This test when found both real and fake
  def test_print_ruby_found_both
    mock_location = Minitest::Mock.new('location')
    def mock_location.name; 'a'; end
    def plural?(x); 'ruby'; end
    assert_output("        Found 1 ruby and 1 fake ruby in a.\n"){
      @p.print_ruby_found_in_this_location(mock_location, [1, 1])}
  end

  # This test when found nothing
  def test_print_ruby_found_nothing
    mock_location = Minitest::Mock.new('location')
    def mock_location.name; 'a'; end
    assert_output("        Found no rubies or fake rubies in a.\n"){
      @p.print_ruby_found_in_this_location(mock_location, [0, 0])}
  end

  # This test when argument is nil
  # EDGE CASE
  def test_print_ruby_found_nil
    mock_location = Minitest::Mock.new('location')
    def mock_location.name; 'a'; end
    def plural?(x); 'ruby'; end
    assert_raises(StandardError){@p.print_ruby_found_in_this_location(mock_location, nil)}
  end

  # UNIT TESTS FOR print_heading(x, y)
  # Equivalence classes:
  # p_location & c_location is int
  # p_location & c_location is float
  # p_location & c_location is string
  # p_location & c_location is nil (EDGE CASE)
  # This test when p_location & c_location is int
  def test_print_heading_int
    assert_output("Heading from 1 to 2\n") {@p.print_heading(1, 2)}
  end

  # This test when p-location & c_location is float
  def test_print_heading_float
    assert_output("Heading from 1.1 to 1.2\n"){@p.print_heading(1.1, 1.2)}
  end

  # This test when p-location & c_location is string
  def test_print_heading_string
    assert_output("Heading from a to b\n"){@p.print_heading('a', 'b')}
  end

  # This test when p-location & c_location is string
  # EDGE CASE
  def test_print_heading_nil
    assert_output("Heading from  to \n"){@p.print_heading(nil, nil)}
  end

  # UNIT TEST FOR plural?(x)
  # Equivalence classes:
  # num = nil, raise
  # num = string, raise
  # num = float, output
  # num = 0, nil (EDGE CASE)
  # num = 1, ruby
  # num = 2, rubies
  # This is test when argument is nil
  def test_plural_nil
    assert_raises(StandardError) {@p.plural?(nil)}
  end

  # This is test when argument is string
  def test_plural_string
    assert_raises(StandardError) {@p.plural?('1')}
  end

  # This is test when argument is float
  def test_plural_float
    assert_raises(StandardError) {@p.plural?(nil)}
  end

  # This test when argument is 0
  # EDGE CASE
  def test_plural_zero
    assert_nil @p.plural?(0) # pass
  end

  # This test when argument is 1
  def test_plural_int
    assert_equal @p.plural?(1), 'ruby'
  end

  # This test when argument is 2
  def test_plural_int2
    assert_equal @p.plural?(2), 'rubies'
  end

  # UNIT TESTS FOR mood?(x)
  # Equvalent classes:
  # total = nil (EDGE CASE)
  # total = 0
  # total = 1
  # total = 5
  # total = 9
  # total = 10
  # total = 100
  # This test when found no ruby
  def test_mood1
    assert_equal @p.mood?([0, 0]), 'empty-handed.'
  end

  # This test when found 1 rubies
  def test_mood2
    assert_equal @p.mood?([1, 0]), 'sad.'
  end

  # This test when found 5 rubies
  def test_mood3
    assert_equal @p.mood?([5, 0]), 'sad.'
  end

  # This test when found 9 rubies
  def test_mood4
    assert_equal @p.mood?([9, 0]), 'sad.'
  end

  # This test when found 10 rubies
  def test_mood5
    assert_equal @p.mood?([10, 0]), 'victorious!'
  end

  # This test when found 100 rubies
  def test_mood6
    assert_equal @p.mood?([100, 0]), 'victorious!'
  end

  # UNIT TESTS FOR show_rush_result(x, y, [])
  def test_show_rush_result
    assert_output("After 2 days, Rubyist 1 found:
        10 rubies.
        10 fake rubies.
Going home victorious!\n"){ @p.show_rush_result(2, 1, [10, 10]) }
  end

  # UNIT TEST FOR dig(location, rng)
  # Equvalent classes:
  # since mock_rng only return the same array that predefined, 
  # passing something other than [0,0] will loop infinitely, 
  # to see if this is true, please change the [0,0] to any other non-zero pair
  # This test the output when only loop once
  def test_dig_once
    mock_location = Minitest::Mock.new('location')
    mock_rng = Minitest::Mock.new('rng')
    def mock_location.name; 'a'; end
    def mock_location.random_total_ruby(mock_rng); [0, 0]; end
    assert_output("        Found no rubies or fake rubies in a.\n"){@p.dig(mock_location, mock_rng)}
  end

  # UNIT TEST FOR ruby_rush(location)
  # Equvalent classes:
  # no turns to make
  # more than 1 turn
  # This test when no turn is needed
  # EDGE CASE
  def test_ruby_rush_no_turn
    mock_location = Minitest::Mock.new('location')
    mock_rng = Minitest::Mock.new('rng')
    @p2 = Prospector.new(1, 0, mock_rng)
    def mock_location.name; 'a'; end
    def mock_location.random_total_ruby(mock_rng); [0, 0]; end
    assert_output("Rubyist #1 starting in Enumerable Canyon.
        Found no rubies or fake rubies in a.
After 1 days, Rubyist 1 found:
        0 rubies.
        0 fake rubies.
Going home empty-handed.\n"){@p2.ruby_rush(mock_location)}
  end

  # UNIT TEST FOR ruby_rush(location)
  # Equvalent classes:
  # no turns to make
  # more than 1 turn
  # This test when 0 prospector is passed, if run "ruby ruby_rush.rb",
  # it should output nothing, however, in this case it should print Rubyist #0
  # EDGE CASE
  def test_ruby_rush_no_rubyist
    mock_location = Minitest::Mock.new('location')
    mock_rng = Minitest::Mock.new('rng')
    @p2 = Prospector.new(0, 0, mock_rng)
    def mock_location.name; 'a'; end
    def mock_location.random_total_ruby(mock_rng); [0, 0]; end
    assert_output("Rubyist #0 starting in Enumerable Canyon.
        Found no rubies or fake rubies in a.
After 1 days, Rubyist 0 found:
        0 rubies.
        0 fake rubies.
Going home empty-handed.\n"){@p2.ruby_rush(mock_location)}
  end

  # This test when at least one turn is needed
  def test_ruby_rush_turns
    mock_location = Minitest::Mock.new('location')
    mock_rng = Minitest::Mock.new('rng')
    @p2 = Prospector.new(1, 2, mock_rng)
    def mock_location.name; 'a'; end
    def mock_location.go_to_next(mock_rng); [self, self][0];end
    def mock_location.random_total_ruby(mock_rng); [0, 0]; end
    assert_output("Rubyist #1 starting in Enumerable Canyon.
        Found no rubies or fake rubies in a.
Heading from a to a
        Found no rubies or fake rubies in a.
        Found no rubies or fake rubies in a.
After 3 days, Rubyist 1 found:
        0 rubies.
        0 fake rubies.
Going home empty-handed.\n"){@p2.ruby_rush(mock_location)}
  end
end
