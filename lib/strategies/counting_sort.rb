require_relative '../sorting_strategy'

class CountingSort
  include SortingStrategy

  def sort(array)
    return array if array.empty?

    max_value = array.max
    min_value = array.min

    count_hash = Hash.new(0)
    array.each { |num| count_hash[num - min_value] += 1 }

    cumulative = 0
    count_hash.each_key.sort.each do |key|
      count_hash[key] = (cumulative += count_hash[key])
    end

    output_array = Array.new(array.length)
    (array.length - 1).downto(0) do |i|
      adjusted_value = array[i] - min_value
      output_array[count_hash[adjusted_value] - 1] = array[i]
      count_hash[adjusted_value] -= 1
    end

    output_array
  end
end