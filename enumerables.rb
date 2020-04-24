module Enumerable
  def my_each
    for value in self
      yield(value)
    end
  end

  def my_each_with_index
    my_each do |item|
      yield(item, index(item))
    end
  end
end
# my_array = [1, 2, 3, 4, 5, 6]
# my_array.my_each { |num| puts num * 2 }
%w[cat dog mouse].my_each_with_index { |item, index| puts "#{item} #{index}" }
