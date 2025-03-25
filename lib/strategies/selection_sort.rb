require_relative '../sorting_strategy'

class SelectionSort
  include SortingStrategy

  def sort(array, sorter)
    n = array.length
    (0...n-1).each do |i|
      min_index = i
      (i+1...n).each do |j|
        sorter.increment_comparisons
        min_index = j if array[j] < array[min_index]
      end

      if min_index != i
        sorter.increment_swaps
        array[i], array[min_index] = array[min_index], array[i]
      end
    end
    array
  end
end