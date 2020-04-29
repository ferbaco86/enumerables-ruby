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

  def my_all?
    true_elements = []
    my_each do |item|
      unless item == false || item == nil
        true_elements.push(item)
      elsif
        true_elements.my_each do |element|
        end 
        return false
      end
    end
    end

  
end

 #p [false, false, 2].all?(false) 
 #p [false, false, 2].all?{|num| num > 1} (false)
 
 p [4, nil, 3].my_all?
 # p [nil, nil, nil].all?

#p [3, 3, false].my_all? 
#p [3, 3, false].all? 

#p [false, false, false].my_all? 
#p [false, false, false].all? 


# my_array = [1, 2, 3, 4, 5, 6]
# my_string = 'Fernando'
# my_hash = { 'Fernando' => 1986, 'Rocio' => 1995, 'Joaquin' => 1988 }

# p my_array.all? { |num| num < 7 }
# p my_array.my_all? { |num| num < 7 }
# p %w[ant bear cat].all? { |word| word.length >= 4 }
# p %w[ant bear cat].my_all? { |word| word.length >= 4 }
# p [1, 2i, 3.14].all?(String)
# p [1, 2i, 3.14].my_all?(String)

# p [true, true, true].all?
# p [true, true, true].my_all?

# p [].all?
# p [].my_all? 

# my_array.each { |num| puts "Each original method: #{num}" }
# puts "Array each original method: #{ my_array.each {|num|} }"
# puts "Array my_each method: #{ my_array.my_each {|num|} }"
# my_array.my_each { |num| puts "My Each method: #{num}" }

# my_array.each_with_index { |item, index| puts "each_with_index original method:#{item} #{index}" }
# puts "Array each_with_index original method: #{ my_array.each_with_index {|item, index|} }"
# puts "Array my_each_with_index method: #{ my_array.my_each_with_index {|item, index|} }"
# my_array.my_each_with_index { |item, index| puts "my_each_with_index method: #{item} #{index}" }

# my_array.select { |num| puts "select original method:#{num} #{num.even?}" }
# my_array.my_select { |num| puts "my_select  method:#{num} #{num.even?}" }

# puts "Array select original method : #{ my_array.select {|num| num.even? }}"
# puts "Array my_select method : #{ my_array.my_select {|num| num.even? }}"

# puts "select original method : #{ my_array.select {|num| num > 2 }}"
# my_array.select { |num| puts " #{num} is greater than 2?: #{num > 2 }"}
# my_array.my_select { |num| puts " #{num} is greater than 2?: #{num > 2 }"}
# puts "my_select method : #{ my_array.my_select {|num| num > 2 }}"

# my_hash.each { |item, index| puts "each original method: #{item} #{index}" }
# puts "Hash each original method: #{ my_hash.each_with_index {|item, index|} }"
# puts "Hash my_each method: #{ my_hash.my_each_with_index {|item, index|} }"
# my_hash.my_each { |item, index| puts "my_each method: #{item} #{index}" }

# my_hash.each_with_index { |item, index| puts "each_with_index original method: #{item} #{index}" }
# puts "Hash each_with_index original method: #{ my_hash.each_with_index {|item, index|}}"
# puts "Hash my_each_with_index method: #{ my_hash.my_each_with_index {|item, index|}}"
# my_hash.my_each_with_index { |item, index| puts "my_each_with_index method: #{item} #{index}" }

# puts "Hash select original method : #{ my_hash.select {|key, value| value > 1990 }}"
# puts "Hash my_select original method : #{ my_hash.my_select {|key, value| value > 1990 }}"



# %w[cat dog mouse].my_each_with_index {|pet, index| puts "#{pet} #{index}"}
