require_relative '../sorting_strategy'

class TimSort
  include SortingStrategy

  MIN_RUN = 32

  def sort(array, sorter)
    return array if array.length <= 1

    result = array.dup
    n = result.length

    (0...n).step(MIN_RUN) do |start|
      end_idx = [start + MIN_RUN - 1, n - 1].min
      insertion_sort(result, start, end_idx, sorter)
    end

    size = MIN_RUN
    while size < n
      (0...n).step(2 * size) do |left|
        mid = [left + size - 1, n - 1].min
        right = [left + 2 * size - 1, n - 1].min

        merge(result, left, mid, right, sorter) if mid < right
      end
      size *= 2
    end
    result
  end

  private

  def insertion_sort(array, left, right, sorter)
    (left + 1..right).each do |i|
      key = array[i]
      j = i - 1
      while j >= left && array[j] > key
        sorter.increment_comparisons
        array[j + 1] = array[j]
        sorter.increment_swaps
        j -= 1
      end
      array[j + 1] = key
    end
    array
  end

  def merge(array, left, mid, right, sorter)
    len1 = mid - left + 1
    len2 = right - mid

    left_array = array[left..mid]
    right_array = array[(mid + 1)..right]

    i = j = 0
    k = left

    while i < len1 && j < len2
      sorter.increment_comparisons
      if left_array[i] <= right_array[j]
        array[k] = left_array[i]
        i += 1
      else
        array[k] = right_array[j]
        j += 1
      end
      sorter.increment_swaps
      k += 1
    end

    while i < len1
      array[k] = left_array[i]
      i += 1
      k += 1
      sorter.increment_swaps
    end

    while j < len2
      array[k] = right_array[j]
      j += 1
      k += 1
      sorter.increment_swaps
    end
  end
end