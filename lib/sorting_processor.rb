require 'parallel'
require 'thread'

class SortingProcessor
  def initialize(file_handler, algorithms)
    @file_handler = file_handler
    @algorithms = algorithms
    @sorter = Sorter.new(algorithms.first)
  end

  def process_all_files(mode: :sequential)
    case mode
    when :threads
      process_with_threads
    when :processes
      process_with_processes
    else
      process_sequentially
    end
  end

  private

  def process_sequentially
    @file_handler.input_files.each do |file_path|
      process_single_file(file_path)
    end
  end

  def process_with_threads
    threads = @file_handler.input_files.map do |file_path|
      Thread.new { process_single_file(file_path) }
    end
    threads.each(&:join)
  end

  def process_with_processes
    Parallel.each(@file_handler.input_files, in_processes: Parallel.processor_count) do |file_path|
      process_single_file(file_path)
    end
  end

  def process_single_file(file_path)
    numbers = @file_handler.read_numbers(file_path)

    threads = @algorithms.map do |algorithm|
      Thread.new { process_with_algorithm(numbers.dup, file_path, algorithm) }
    end
    threads.each(&:join)
  end

  def process_with_algorithm(numbers, file_path, algorithm)
    algorithm_name = algorithm.class.to_s

    @sorter.strategy = algorithm
    start_time = Time.now
    sorted_numbers = @sorter.sort(numbers)
    end_time = Time.now

    metrics = {
      algorithm: algorithm_name,
      execution_time: (end_time - start_time),
      comparisons: @sorter.comparisons || 0,
      swaps: @sorter.swaps || 0
    }

    @file_handler.save_sorted_numbers(sorted_numbers, file_path, algorithm_name)
    log_metrics(metrics)
  end

  def log_metrics(metrics)
    puts "Algorithm: #{metrics[:algorithm]}, Time: #{metrics[:execution_time]}s, " \
         "Comparisons: #{metrics[:comparisons]}, Swaps: #{metrics[:swaps]}"
  end
end