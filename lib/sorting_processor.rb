class SortingProcessor
  def initialize(file_handler, algorithms)
    @file_handler = file_handler
    @algorithms = algorithms
    @sorter = Sorter.new(algorithms.first)
  end

  def process_all_files
    @file_handler.input_files.each do |file_path|
      process_single_file(file_path)
    end
  end

  private

  def process_single_file(file_path)
    numbers = @file_handler.read_numbers(file_path)

    @algorithms.each do |algorithm|
      process_with_algorithm(numbers, file_path, algorithm)
    end
  end

  def process_with_algorithm(numbers, file_path, algorithm)
    algorithm_name = algorithm.class.to_s

    @sorter.strategy = algorithm
    sorted_numbers = @sorter.sort(numbers)

    @file_handler.save_sorted_numbers(sorted_numbers, file_path, algorithm_name)
  end
end 