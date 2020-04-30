module Enumerable
  # This method will execute the block for each of the array's elements.

  def my_each
    return enum_for(:my_each) unless block_given?

    cont = 0
    arr = * self # Use an if to ask for its a  (1..3).my_each is_a? Range 

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
  # The method returns true if the block ever returns a value other than false or nil.
  # If the block is not given, Ruby adds an implicit block of { |obj| obj }
  # that will cause any? to return true if at least one of the collection members is not false or nil.
  # If instead a pattern is supplied, the method returns whether pattern === element for any collection member.

  def my_any?(args = nil)
    return false if empty?

    true_elements = []
    my_each do |item|
      if block_given?
        true_elements.push(item) if yield(item)
      elsif !args.nil?
        true_elements.push(item) if args === item
      elsif item
        true_elements.push(item)
      end
    end
    true_elements.empty? ? false : true
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

  # Returns the number of items in enum through enumeration.
  # If an argument is given, the number of items in enum that are equal to item are counted.
  # If a block is given, it counts the number of elements yielding a true value.

  def my_count(args = nil)
    item_counter = 0
    my_each do |item|
      if !args.nil?
        item_counter += 1 if item == args
      elsif block_given?
        item_counter += 1 if yield(item)
      else
        item_counter += 1
      end
    end
    item_counter
  end

  # Returns a new array with the results of running block once for every element in enum.
  # If no block is given, an enumerator is returned instead.

  def my_map(&args)
    return enum_for unless block_given?

    new_array = []
    my_each do |item|
      new_array.push(args.call(item))
    end
   new_array
  end

  # Combines all elements of enum by applying a binary operation, specified by a block or a symbol that names a method or operator.
  # If you specify a block, then for each element in enum the block is passed an accumulator value (memo) and the element. 
  # If you specify a symbol instead, then each element in the collection will be passed to the named method of memo. 
  # In either case, the result becomes the new value for memo. At the end of the iteration, the final value of memo is the return value for the method.
  # If you do not explicitly specify an initial value for memo, then the first element of collection is used as the initial value of memo.

  def my_inject(*args)
    arr = *self
    if block_given?
      temp = args[0] if args.length == 1
      temp = arr.shift unless args.nil? || args.length == 1
      arr.my_each do |item|
        temp = yield(temp, item)
      end
    else
      temp = arr.shift unless args.nil? || args.length == 2
      arr.my_each do |item|
        temp = temp.send(args[0].to_s, item)
      end
    end
    temp
  end
end

def multiply_els(args)
   puts args.my_inject(:*)
end

map = proc do |num|
      num * num
end

p [1, 2, 3, 4].my_map(&map)
