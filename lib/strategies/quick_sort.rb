require_relative '../sorting_strategy'

class QuickSort
  include SortingStrategy

  def sort(array)
    return array if array.length <= 1

    pivot = array.delete_at(rand(array.length))
    left, right = array.partition { |x| x < pivot }

    sort(left) + [pivot] + sort(right)
  end
end
