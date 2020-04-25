module Enumerable
  def my_each
    return enum_for(:my_each) unless block_given?
    for value in self
      yield(value)
    end
  end

  def my_each_with_index
    return enum_for(:my_each_with_index) unless block_given?
    my_each do |item|
      yield(item, index(item))
    end
  end
end
# my_array = [1, 2, 3, 4, 5, 6]
# my_array.my_each { |num| puts num * 2 }
puts %w[cat dog mouse].my_each_with_index
