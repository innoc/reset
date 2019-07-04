#--
# frozen_string_literal: true
#
# @author Innocent Akhidenor <innocent.akhidenor@gmail.com>

# This Set class deals with a collection
# of unordered values with no duplicates.
#
#
# The Set class uses the hash as storage
# and enumerable methods such as each
# and merge to initialize the Set class
# as well as perform key functions.

class Set
  # Creates a new set containing the elements
  # of the given enumerable object.
  # @param enum [Array] an array containing the list of
  #   elements to be included in the Set
  # @return [Set] A Set object
  #
  # @example Initializing the set object
  #   Set.new([1,2,4,5,6,8])  #=> #<Set: {1, 2}>
  #
  def initialize(enum = nil)
    @hash ||= Hash.new(false)
    enum.nil? and return
    merge(enum)
  end

  # Calculates the intersection between to Set objects.
  # @note This method is invoked by the symbol n.
  # @param set [Set] Object
  # @return [Set] a new Set of all objects that are
  #   members of both sets
  #
  # @example
  #   a = Set.new([1,2,3])
  #   b = Set.new([2,3,4])
  #   a.n(b) #=> #<Set: {2, 3}>
  #
  def intersect(set)
    s = self.class.new
    build_set(set.to_a) { |o| s.add(o) if include?(o) }
    s
  end

  alias n intersect

  # The union of two sets is a new Set containing
  # the unique members of those sets.
  # @note This method is invoked by the symbol ∪.
  # @param set [Set] Object
  # @return [Set] a new Set containing
  #   the unique members of the combined set
  #
  # @example
  #   a = Set.new([1,3])
  #   b = Set.new([2,4])
  #   a.u(b) #=> #<Set: {1, 2, 3, 4}>
  #
  def union(set)
    duplicate.merge(set.to_a)
  end

  alias u union

  # The difference of two sets is a new Set
  # of all members of the first set that are
  # not part of the second set.
  # @param set [Set] a Set Object
  # @return [Set] a new Set object
  #
  # @example
  #   a = Set.new([1,2,3])
  #   b = Set.new([2,3,4])
  #   a.-(b) #=> #<Set: {1}>
  #
  def difference(set)
    build_set(set.to_a) { |s| delete(s) }
    self
  end

  alias - difference

  # The subset checks whether the first set is a
  # subset of the second set.
  # @param set [Set] a set Object
  # @return [Boolean] returns true if the first set
  #   is a subset else false
  #
  # @example
  #   a = Set.new([1,2,3])
  #   b = Set.new([1,2,3,4])
  #   a.<=(b) #=> true
  #
  def subset(set)
    self.difference(set).to_a.count == 0
  end

  alias <= subset


  # Displays the content in a Set object as an array.
  # @return [Array] returns an array of objects
  #
  # @example
  #   a = Set.new([1,2,3])
  #   a.to_a #=> [1,2,3]
  #
  def to_a
    @hash.keys
  end

  protected

  # Combines the content of two Set objects.
  # @param enum [Enumberable] Enumberable object
  # @return [Set] set object
  #
  def merge(enum)
    if enum.instance_of?(self.class)
      @hash.update(enum.instance_variable_get(:@hash))
    else
      build_set(enum) { |s| add(s) }
    end
    self
  end

  # Appends a new element into a Set.
  # @return [Set] a set object
  #   with the newly added element.
  #
  def add(s)
    @hash[s] = true
    self
  end

  private

  # A predicate method that checks if an element
  # is included in a Set
  # @return [Bollean] true || false
  #
  def include?(s)
    @hash[s]
  end

  # Deletes an element from a Set
  # @return [Bollean] true || false
  #
  def delete(s)
    @hash.delete(s)
    self
  end

  # Create a duplicated Set object
  # @return [Set] a newly create
  #   set object
  #
  def duplicate
    dup ||= self.class.new(@hash.keys)
  end

  # Applies a block function to an
  # enumerable object
  # @param enum [Enumerable] the object to 
  #  be mutated
  # @option block [Block] the block function
  #  to be applied to the enum object
  # @return [Enumerable] a 
  #   mutated enumerable object
  #
  def build_set(enum, &block)
    if enum.respond_to?(:each_entry)
      enum.each_entry(&block) if block
    elsif enum.respond_to?(:each)
      enum.each(&block) if block
    else
      raise ArgumentError, "value must be enumerable"
    end
  end
end