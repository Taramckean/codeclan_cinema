require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')
require_relative('models/screening')

require('pry')

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()
Screening.delete_all()


customer1 = Customer.new({ 'name' => 'Tara','funds' => 50})
customer1.save()
customer2 = Customer.new({ 'name' => 'Adri','funds' => 5})
customer2.save()
customer3 = Customer.new({ 'name' => 'Cleyra','funds' => 100})
customer3.save()
customer4 = Customer.new({ 'name' => 'John','funds' => 100})
customer4.save()

film1 = Film.new({ 'title' => 'Rocky Horror Picture Show', 'price' => 14})
film1.save()
film2 = Film.new({ 'title' => 'Babe', 'price' => 8 })
film2.save()
film3 = Film.new({ 'title' => 'Ace Ventura', 'price' => 10})
film3.save()
film4 = Film.new({ 'title' => 'Ace Ventura', 'price' => 10})
film4.save()

screening1 = Screening.new({ 'showing' => '13:15', 'film_id' => 1})
screening1.save()
screening2 = Screening.new({ 'showing' => '18:30', 'film_id' => 1})
screening2.save()
screening3 = Screening.new({ 'showing' => '23:00', 'film_id' => 1})
screening3.save()

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'screening_id' => screening1.id})
ticket1.save()
ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'screening_id' => screening1.id})
ticket2.save()
ticket3 = Ticket.new({ 'customer_id' => customer3.id, 'screening_id' => screening1.id})
ticket3.save()
ticket4 = Ticket.new({ 'customer_id' => customer4.id, 'screening_id' => screening2.id})
ticket4.save()
ticket5 = Ticket.new({ 'customer_id' => customer1.id, 'screening_id' => screening3.id})
ticket5.save()

films = Film.all()
customers = Customer.all()

customer1.name = "Louise"
customer1.update()

customer1.buy_ticket(film1)
customer1.update()

updated_customers = Customer.all()

binding.pry
nil
