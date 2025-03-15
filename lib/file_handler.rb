require 'fileutils'

class FileHandler
  def initialize(base_dir = 'results')
    @base_dir = base_dir
    FileUtils.mkdir_p(@base_dir)
  end

  def read_numbers(file_path)
    content = File.read(file_path)
    content.gsub(/\s+/, '').split(',').map(&:to_i)
  end

  def save_sorted_numbers(numbers, original_file, algorithm_name)
    result_dir = File.join(@base_dir, algorithm_name.downcase.gsub(/\s+/, '_'))
    FileUtils.mkdir_p(result_dir)
    
    file_name = File.basename(original_file)
    output_file = File.join(result_dir, "sorted_#{file_name}")
    
    File.write(output_file, numbers.join(','))
  end

  def input_files
    Dir.glob('numbers/*.txt').sort
  end
end