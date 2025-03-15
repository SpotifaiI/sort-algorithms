require_relative 'sorter'
require_relative 'strategies/bubble_sort'
require_relative 'strategies/bubble_sort_enhanced'
require_relative 'file_handler'
require_relative 'sorting_processor'

class SortingApp
  def initialize
    @file_handler = FileHandler.new
    @algorithms = [
      BubbleSort.new,
      BubbleSortEnhanced.new
    ]
  end

  def run
    processor = SortingProcessor.new(@file_handler, @algorithms)
    processor.process_all_files
  end
end