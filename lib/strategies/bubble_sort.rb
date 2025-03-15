require_relative '../sorting_strategy'

class BubbleSort
  include SortingStrategy

  def sort(array)
    n = array.length
    (n-1).times do |i|
      (n-1-i).times do |j|
        if array[j] > array[j + 1]
          array[j], array[j + 1] = array[j + 1], array[j]
        end
      end
    end
    array
  end
end