require_relative '../sorting_strategy'

class BubbleSort
  include SortingStrategy

  def sort(array, sorter)
    n = array.length
    (n-1).times do |i|
      (n-1-i).times do |j|
        sorter.increment_comparisons
        if array[j] > array[j + 1]
          array[j], array[j + 1] = array[j + 1], array[j]
          sorter.increment_swaps
        end
      end
    end
    array
  end
end