# require_relative 'location_test'
# This is a location class
class Location
  attr_accessor :name, :neighbors, :max_ruby
  def initialize(name, num_real, num_fake)
    @name = name
    @neighbors = [] # neighbors is an array
    @max_ruby = [num_real, num_fake]
  end

  # This method helps set up the neighbor of a single locaiton
  def add_neighbors(array_of_neighbors)
    @neighbors = array_of_neighbors
  end

  # This would return the next neighbor pros should go
  # argument: prng
  # return: Location
  def go_to_next(rng)
    choice = rng.rand(0...@neighbors.size)
    @neighbors[choice]
  end

  # This method ruturns the number ruby prospector found in one location
  # argument: prng
  # return: total_num
  def random_total_ruby(rng)
    total_num = [random_real_ruby(rng), random_fake_ruby(rng)]
    total_num
  end

  # This is a helper method to decide number of real ruby found
  # argument: prng
  # return: total_real
  def random_real_ruby(rng)
    total_real = rng.rand(0..@max_ruby[0])
    total_real
  end

  # This is a helper method to decide number of fake ruby found
  # argument: prng
  # return: total_fake
  def random_fake_ruby(rng)
    total_fake = rng.rand(0..@max_ruby[1])
    total_fake
  end
end
