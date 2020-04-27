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

    # for value in self
    #   yield(value)
    # end
  end

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

  def my_select
    return enum_for(:my_select) unless block_given?
    arr = []
    cont = 0

    my_each do |item|
        if yield(item)
          arr.push(item)
        end                          
      end
      arr
  end

  def my_all?( args = nil)
    true_cont = 0
    p args

    my_each do |item|
      true_cont += 1
      is_type = item.is_a? args
    if block_given?
      return false unless yield(item)
    end
      return true if true_cont == self.size
      if is_type
        return true
      else
         return false
      end
    end
  end
end

