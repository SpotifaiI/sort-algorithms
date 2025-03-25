require_relative '../sorting_strategy'

class InsertionSort
  include SortingStrategy

  def sort(array, sorter)
    n = array.length
    (1...n).each do |i|
      key = array[i]
      j = i - 1
      while j >= 0 && array[j] > key
        sorter.increment_comparisons
        array[j + 1] = array[j]
        sorter.increment_swaps
        j -= 1
      end
      sorter.increment_comparisons if j >= 0
      array[j + 1] = key
      sorter.increment_swaps
    end
    array
  end
end