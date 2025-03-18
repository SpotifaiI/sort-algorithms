require_relative '../sorting_strategy'

class RadixSort
  include SortingStrategy

  def initialize(max_range: 1_000)
    @max_range = max_range
  end

  def sort(array)
    return array if array.empty?

    max_number = array.max
    place = 1
    while max_number / place > 0
      array = counting_sort(array, place)
      place *= 10
    end

    array
  end

  private

  def counting_sort(array, place)
    count = Hash.new(0)
    output = Array.new(array.length)

    array.each { |num| count[(num / place) % 10] += 1 }

    cumulative = 0
    count.each_key.sort.each do |digit|
      count[digit] = (cumulative += count[digit])
    end

    (array.length - 1).downto(0) do |i|
      digit = (array[i] / place) % 10
      output[count[digit] - 1] = array[i]
      count[digit] -= 1
    end

    output
  end
end