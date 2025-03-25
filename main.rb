require_relative 'lib/sorting_app'

app = SortingApp.new

app.run(mode: :sequential)
app.run(mode: :threads)
app.run(mode: :processes)