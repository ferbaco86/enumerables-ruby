# rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity,Style/CaseEquality
module Enumerable
  def my_each
    return enum_for(:my_each) unless block_given?

    cont = 0
    arr = * self
    while arr.length > cont
      yield(arr[cont])
      cont += 1
    end
    arr
  end

  def my_each_with_index
    return enum_for(:my_each_with_index) unless block_given?

    cont = 0
    my_each do |item|
      yield(item, cont)
      cont += 1
    end
  end

  def my_select
    return enum_for(:my_select) unless block_given?

    arr = []
    my_each { |item| arr.push(item) if yield(item) }
    arr
  end

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
      end
    end
    false_elements.empty? ? true : false
  end

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

  def my_none?(args = nil)
    return true if empty?

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
    true_elements.empty? ? true : false
  end

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

  def my_map(args = nil)
    return enum_for(:my_map) unless block_given?

    new_array = []
    args.nil? ? my_each { |item| new_array.push(yield(item)) } : my_each { |item| new_array.push(args.call(item)) }
    new_array
  end

  def my_inject(*args)
    arr = *self

    if block_given?
      temp = args[0] if args.length == 1
      temp = arr.shift unless args.nil? || args.length == 1
      arr.my_each { |item| temp = yield(temp, item) }
    else
      temp = args.length > 1 ? args.shift : arr.shift
      arr.my_each { |item| temp = temp.send(args[0].to_s, item) }
      return temp
    end
    temp
  end
end

# rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity,Style/CaseEquality
def multiply_els(args)
  puts args.my_inject(:*)
end
