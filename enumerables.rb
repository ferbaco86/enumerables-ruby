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
      if self.class == Hash
        yield(item, find_index(item))
      else
        yield(item, index(item))
      end
    end
  end
end
my_array = [1, 2, 3, 4, 5, 6]
my_string = 'Fernando'
my_hash = { 'Fernando' => 1986, 'Rocio' => 1995, 'Joaquin' => 1988 }

my_array.my_each { |num| puts num }
my_array.each { |num| puts num }
my_array.my_each_with_index { |item, index| puts "#{item} #{index}" }
my_array.each_with_index { |item, index| puts "#{item} #{index}" }

my_string.split('').my_each { |char| puts char }
my_string.split('').each { |char| puts char }
my_string.split('').my_each_with_index { |item, index| puts "#{item} #{index}" }
my_string.split('').each_with_index { |item, index| puts "#{item} #{index}" }

my_hash.my_each { |item, index| puts "#{item} #{index}" }
my_hash.each { |item, index| puts "#{item} #{index}" }
my_hash.my_each_with_index { |item, index| puts "#{item} #{index}" }
my_hash.each_with_index { |item, index| puts "#{item} #{index}" }

# %w[cat dog mouse].my_each_with_index {|pet, index| puts "#{pet} #{index}"}
