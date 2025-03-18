require_relative '../sorting_strategy'

class ShellSort
  include SortingStrategy
  
  def sort(array)
    return array if array.length <= 1
    
    result = array.dup
    n = result.length
    
    gap = 1
    while gap < n/3
      gap = gap * 3 + 1
    end
    
    while gap > 0
      for i in gap...n
        temp = result[i]
        
        j = i
        while j >= gap && result[j - gap] > temp
          result[j] = result[j - gap]
          j -= gap
        end
        
        result[j] = temp
      end
      
      gap = (gap - 1) / 3
    end
    
    result
  end
end