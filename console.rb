require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

require('pry')

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()


customer1 = Customer.new({ 'name' => 'Tara','funds' => 50})
customer1.save()
customer2 = Customer.new({ 'name' => 'Adri','funds' => 5})
customer2.save()
customer3 = Customer.new({ 'name' => 'Cleyra','funds' => 100})
customer3.save()

film1 = Film.new({ 'title' => 'Rocky Horror Picture Show', 'price' => 14})
film1.save()
film2 = Film.new({ 'title' => 'Babe', 'price' => 8 })
film2.save()
film3 = Film.new({ 'title' => 'Ace Ventura', 'price' => 14})
film3.save()


ticket1 = Ticket.new({ 'customer_id' => 1, 'film_id' => 2})
ticket1.save()
ticket2 = Ticket.new({ 'customer_id' => 1, 'film_id' => 3})
ticket2.save()
ticket3 = Ticket.new({ 'customer_id' => 2, 'film_id' => 1})
ticket3.save()
ticket4 = Ticket.new({ 'customer_id' => 3, 'film_id' => 1})
ticket4.save()

films = Film.all()
customers = Customer.all()

customer1.name = "Louise"
customer1.update()

updated_customers = Customer.all()

binding.pry
nil
