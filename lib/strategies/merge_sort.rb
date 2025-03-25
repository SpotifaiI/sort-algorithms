require_relative '../sorting_strategy'

class MergeSort
  include SortingStrategy

  def sort(array, sorter)
    return array if array.length <= 1

    mid = array.length / 2
    left_half = sort(array[0...mid], sorter)
    right_half = sort(array[mid..], sorter)

    merge(left_half, right_half, sorter)
  end

  private

  def merge(left, right, sorter)
    sorted = []
    until left.empty? || right.empty?
      sorter.increment_comparisons
      if left.first <= right.first
        sorted << left.shift
        sorter.increment_swaps
      else
        sorted << right.shift
        sorter.increment_swaps
      end
    end
    left.each do |elem|
      sorted << elem
      sorter.increment_swaps
    end
    right.each do |elem|
      sorted << elem
      sorter.increment_swaps
    end
    sorted
  end
end