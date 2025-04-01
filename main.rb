require_relative 'lib/sorting_app'
require_relative 'lib/binary_search'

app = SortingApp.new

puts "Sequential"
app.run(mode: :sequential)
puts "================"
puts "Threads"
app.run(mode: :threads)
puts "================"
puts "Processes"
app.run(mode: :processes)

base_array = File.readlines('numbers/ordered_numbers.txt')[0].split(',').map(&:to_i)
searcher = BinarySearchWithCache.new(base_array)

tests = base_array.sample(10)
tests.each do |target|
  result = searcher.search(target)
  if result != -1
    puts "Elemento #{target} encontrado no índice #{result}"
  else
    puts "Elemento #{target} não encontrado no array"
  end
end