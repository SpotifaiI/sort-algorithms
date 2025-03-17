require_relative '../sorting_strategy'

class MergeSort
  include SortingStrategy

  def sort(array)
    return array if array.length <= 1

    mid = array.length / 2
    left_half = sort(array[0...mid])
    right_half = sort(array[mid..])

    merge(left_half, right_half)
  end

  private

  def merge(left, right)
    sorted = []
    until left.empty? || right.empty?
      if left.first <= right.first
        sorted << left.shift
      else
        sorted << right.shift
      end
    end
    sorted + left + right
  end
end