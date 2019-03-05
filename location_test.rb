# Note that we require and start simplecov before
# doing ANYTHING else, including other require statements.
require 'simplecov'
require_relative 'location'

# This is the test class for location.rb
class LocationTest < Minitest::Test
  # Special method!
  # This will run the following code before each test
  # We will re-use the instance variable in each method
  # This was we don't have to type @l = Location.new(x,y,z) in each test

  def setup
    @l1 = Location.new('a', 10, 10)
    @l2 = Location.new('b', 8, 8)
    @l3 = Location.new('c', 9, 9)
  end

  # UNIT TESTS FOR accessor
  # Equivalence classes:
  # location.name --> name
  # location.neighbors --> [neighbor1, neigbor2]
  # location.max_ruby --> [real, fake]
  def test_location_name
    assert_equal @l1.name, 'a' # pass
  end

  # This test the add_neighbors([x])
  def test_add_neighbors
    @l1.add_neighbors([@l2, @l3])
    assert_equal @l1.neighbors.size, 2 # pass
  end

  # This test the neighbor accessor
  def test_location_no_neighbors
    assert_equal @l1.neighbors, [] # pass
  end

  # This test the neighbor accessor
  def test_location_has_neighbors
    @l1.add_neighbors([@l2, @l3])
    assert_equal @l1.neighbors, [@l2, @l3] # pass
  end

  # This test the max_ruby accessor
  def test_location_max_ruby
    assert_equal @l1.max_ruby, [10, 10] # pass
  end

  # UNIT TESTS FOR random_total_ruby(rng)
  def test_random_total_ruby
    mock_rng = Minitest::Mock.new('rng')
    def mock_rng.rand(x); 1; end
    def random_fake_ruby(mock_rng); 1; end
    def random_real_ruby(mock_rng); 1; end
    assert_equal @l1.random_total_ruby(mock_rng), [1, 1]
  end

  # UNIT TESTS FOR random_fake_ruby(rng)
  def test_random_fake_ruby
    mock_rng = Minitest::Mock.new('rng')
    def mock_rng.rand(x); 1; end
    val = @l1.random_fake_ruby(mock_rng)
    assert_equal val, 1 # pass
  end

  # UNIT TESTS FOR random_real_ruby(rng)
  def test_random_real_ruby
    mock_rng = Minitest::Mock.new('rng')
    def mock_rng.rand(x); 1; end
    result = @l1.random_real_ruby(mock_rng)
    assert_equal result, 1 # pass
  end

  # UNIT TEST FOR go_to_next(rng)
  def test_go_to_next
    @l1.add_neighbors([@l2, @l3])
    mock_rng = Minitest::Mock.new('rng')
    def mock_rng.rand(x); 1; end
    assert_equal @l1.go_to_next(mock_rng), @l3 # pass
  end
end
