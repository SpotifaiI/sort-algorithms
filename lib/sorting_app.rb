require_relative 'sorter'
require_relative 'file_handler'
require_relative 'sorting_processor'
require_relative 'strategies/bubble_sort_enhanced'
require_relative 'strategies/bubble_sort'
require_relative 'strategies/counting_sort'
require_relative 'strategies/heap_sort'
require_relative 'strategies/insertion_sort'
require_relative 'strategies/merge_sort'
require_relative 'strategies/quick_sort'
require_relative 'strategies/radix_sort'
require_relative 'strategies/selection_sort'
require_relative 'strategies/shell_sort'
require_relative 'strategies/tim_sort'

class SortingApp
  def initialize
    @file_handler = FileHandler.new
    @algorithms = [
      BubbleSort.new,
      BubbleSortEnhanced.new,
      InsertionSort.new,
      SelectionSort.new,
      MergeSort.new,
      CountingSort.new,
      RadixSort.new,
      QuickSort.new,
      HeapSort.new,
      TimSort.new,
      ShellSort.new
    ]
  end

  def run(mode: :sequential)
    processor = SortingProcessor.new(@file_handler, @algorithms)
    processor.process_all_files(mode: mode)
  end
end