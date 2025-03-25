require_relative '../sorting_strategy'

class HeapSort
  include SortingStrategy

  def sort(array, sorter)
    n = array.length

    (n / 2 - 1).downto(0) { |i| heapify(array, n, i, sorter) }

    (n - 1).downto(1) do |i|
      sorter.increment_swaps
      array[0], array[i] = array[i], array[0]
      heapify(array, i, 0, sorter)
    end

    array
  end

  private

  def heapify(array, n, i, sorter)
    largest = i
    left = 2 * i + 1
    right = 2 * i + 2

    if left < n
      sorter.increment_comparisons
      largest = left if array[left] > array[largest]
    end

    if right < n
      sorter.increment_comparisons
      largest = right if array[right] > array[largest]
    end

    if largest != i
      sorter.increment_swaps
      array[i], array[largest] = array[largest], array[i]
      heapify(array, n, largest, sorter)
    end
  end
end