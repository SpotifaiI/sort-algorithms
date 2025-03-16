require_relative '../sorting_strategy'

class CountingSort
  include SortingStrategy

  def sort(array)
    return array if array.empty?
    
    max_value = array.max
    min_value = array.min
    range = max_value - min_value + 1
    
    count_array = Array.new(range, 0)
    output_array = Array.new(array.length)
    
    array.each { |num| count_array[num - min_value] += 1 }
    
    (1...range).each { |i| count_array[i] += count_array[i - 1] }
    
    (array.length - 1).downto(0) do |i|
      output_array[count_array[array[i] - min_value] - 1] = array[i]
      count_array[array[i] - min_value] -= 1
    end
    
    output_array
  end
end
