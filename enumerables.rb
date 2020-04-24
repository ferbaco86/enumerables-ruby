module Enumerable
  def my_each
    for value in self
      yield(value)
    end
  end
end

my_array = [1,2,3,4,5,6]

my_array.my_each {|num| puts num * 2}

