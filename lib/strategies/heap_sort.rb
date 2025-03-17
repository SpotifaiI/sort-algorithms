require_relative '../sorting_strategy'

class HeapSort
  include SortingStrategy

  def sort(array)
    n = array.length

    (n / 2 - 1).downto(0) { |i| heapify(array, n, i) }

    (n - 1).downto(1) do |i|
      array[0], array[i] = array[i], array[0] 
      heapify(array, i, 0) 
    end

    array
  end

  private

  def heapify(array, n, i)
    largest = i
    left = 2 * i + 1
    right = 2 * i + 2

    largest = left if left < n && array[left] > array[largest]

    largest = right if right < n && array[right] > array[largest]

    if largest != i
      array[i], array[largest] = array[largest], array[i]
      heapify(array, n, largest) 
    end
  end
end
