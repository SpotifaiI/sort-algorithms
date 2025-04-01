class BinarySearchWithCache
  def initialize(array)
    @array = array
    @cache = Hash.new
  end

  def search(target)
    if @cache.key?(target)
      return @cache[target]
    end

    result = binary_recursive_search(target, 0, @array.length - 1)
    @cache[target] = result
    result
  end

  private

  def binary_recursive_search(target, start, stop)
    return -1 if start > stop

    middle = (start + stop) / 2

    return middle if @array[middle] == target

    if target < @array[middle]
      binary_recursive_search(target, start, middle - 1)
    else
      binary_recursive_search(target, middle + 1, stop)
    end
  end
end