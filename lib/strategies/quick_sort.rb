require_relative '../sorting_strategy'

class QuickSort
  include SortingStrategy

  def sort(array, sorter)
    return array if array.length <= 1

    pivot = array.delete_at(rand(array.length))
    left = []
    right = []

    array.each do |x|
      sorter.increment_comparisons
      if x < pivot
        left << x
        sorter.increment_swaps
      else
        right << x
        sorter.increment_swaps
      end
    end

    sorted_left = sort(left, sorter)
    sorted_right = sort(right, sorter)
    
    sorted_left + [pivot] + sorted_right
  end
end