require_relative '../sorting_strategy'

class ShellSort
  include SortingStrategy

  def sort(array, sorter)
    return array if array.length <= 1

    result = array.dup
    n = result.length

    gap = 1
    while gap < n/3
      gap = gap * 3 + 1
    end

    while gap > 0
      (gap...n).each do |i|
        temp = result[i]
        j = i

        while j >= gap && result[j - gap] > temp
          sorter.increment_comparisons
          result[j] = result[j - gap]
          sorter.increment_swaps
          j -= gap
        end

        result[j] = temp
      end

      gap = (gap - 1) / 3
    end

    result
  end
end