module Enumerable
  # This method will execute the block for each of the array's elements.

  def my_each
    return enum_for(:my_each) unless block_given?

    cont = 0
    arr = * self

    while arr.length > cont
      yield(arr[cont])
      cont += 1
    end
    arr

    # for value in self
    #   yield(value)
    # end
  end

  # Calls block with two arguments, the item and its index, for each item in enum.
  # Given arguments are passed through to each().
  # If no block is given, an enumerator is returned instead.

  def my_each_with_index
    return enum_for(:my_each_with_index) unless block_given?

    my_each do |item|
      if self.class == Hash
        yield(item, find_index(item))
      else
        yield(item, index(item))
      end
    end
  end

  # Returns an array containing all elements of enum for which the given block returns a true value.

  def my_select
    return enum_for(:my_select) unless block_given?

    arr = []
    my_each do |item|
      arr.push(item) if yield(item)
    end
    arr
  end

  # Passes each element of the collection to the given block.
  # The method returns true if the block never returns false or nil.
  # If the block is not given, Ruby adds an implicit block of { |obj| obj }
  # which will cause all? to return true when none of the collection members are false or nil.
  # If instead a pattern is supplied, the method returns whether pattern === element for every collection member.

  # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
  def my_all?(args = nil)
    return true if empty?

    false_elements = []
    my_each do |item|
      if block_given?
        false_elements.push(item) unless yield(item)
      elsif !args.nil?
        false_elements.push(item) unless args === item
      elsif !item || item.nil?
        false_elements.push(item)
        # false_elements.push(item) if !item || item.nil?
      end
    end
    false_elements.empty? ? true : false
  end

  # Passes each element of the collection to the given block.
  # The method returns true if the block never returns true for all elements.
  # If the block is not given, none? will return true only if none of the collection members is true.
  # If instead a pattern is supplied, the method returns whether pattern === element for none of the collection members.

  def my_none?(args = nil)
    return true if empty?

    true_elements = []
    my_each do |item|
      if block_given?
        true_elements.push(item) if yield(item)
        p true_elements
      elsif !args.nil?
        true_elements.push(item) if args === item
      elsif item
        true_elements.push(item)
      end
    end
    true_elements.empty? ? true : false
  end
  # rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
end
