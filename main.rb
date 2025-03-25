require_relative 'lib/sorting_app'

app = SortingApp.new

puts "Sequential"
app.run(mode: :sequential)
puts "================"
puts "Threads"
app.run(mode: :threads)
puts "================"
puts "Processes"
app.run(mode: :processes)