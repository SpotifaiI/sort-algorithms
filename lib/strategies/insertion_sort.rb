require_relative '../sorting_strategy'

class InsertionSort
  include SortingStrategy

  def sort(array)
    n = array.length
    (1...n).each do |i|
      key = array[i]
      j = i - 1
      while j >= 0 && array[j] > key
        array[j + 1] = array[j]
        j -= 1
      end
      array[j + 1] = key
    end
    array
  end
end