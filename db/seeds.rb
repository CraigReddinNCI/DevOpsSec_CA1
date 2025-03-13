# db/seeds.rb

# Create some sample todos
Todo.create([
  { todoname: 'Buy groceries', tododescription: 'Milk, eggs, bread, and cheese' }
])

# Output a message to confirm seeds were added
puts "Seed data has been added to the Todos table!"
