require 'minitest/autorun'
require 'minitest/hooks/default'
require 'minitest/rg'

require_relative '../lib/set'

class SetTest < Minitest::Test
  include Minitest::Hooks

  before(:all) do
    @first_set  = Set.new([1, 2, 3, 4])
    @second_set = Set.new([3, 4])
  end

  def test_initializing_a_set_with_an_array
    x = Set.new([1,2,3])

    assert_equal Set, x.class
    assert_equal [1,2,3], x.to_a
  end

  def test_initializing_a_set_with_a_range
    x = Set.new(1..5)

    assert_equal Set, x.class
    assert_equal [1,2,3,4,5], x.to_a
  end

  def test_initializing_a_set_with_no_argument
    x = Set.new
    assert_equal Set, x.class
    assert_equal [], x.to_a
  end

  def test_intersection
    x = Set.new([1,2,3])
    y = Set.new([2,3,4])
    intersect = x.n(y)

    assert_equal Set, intersect.class
    assert_equal [2,3], intersect.to_a
  end

  def test_union
    x = Set.new([1,3])
    y = Set.new([2,4])
    union = x.u(y)

    assert_equal Set, union.class
    assert_equal [1,3,2,4], union.to_a
  end

  def test_difference
    x = Set.new([1,2,3])
    y = Set.new([2,3,4])
    difference = x.-(y)

    assert_equal Set, difference.class
    assert_equal [1], difference.to_a
  end

  def test_that_subset_returns_true
    x = Set.new([1,2,3])
    y = Set.new([1,2,3,4])
    subset = x.<=(y)

    assert_equal TrueClass, subset.class
    assert_equal subset, true
  end

  def test_that_subset_returns_false
    x = Set.new([1,2,3,5])
    y = Set.new([1,2,3,4])
    subset = x.<=(y)

    assert_equal FalseClass, subset.class
    assert_equal subset, false
  end
end