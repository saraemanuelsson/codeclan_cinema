require('pry')
require_relative('./models/customer')
require_relative('./models/film')
require_relative('./models/ticket')
require_relative('./models/screening')

Screening.delete_all()
Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

harry = Customer.new({ 'name' => 'Harry Potter', 'funds' => 68 })
hermione = Customer.new({ 'name' => 'Hermione Granger', 'funds' => 37 })
ron = Customer.new({ 'name' => 'Ron Weasley', 'funds' => 9 })

harry.save()
hermione.save()
ron.save()

avengers = Film.new({ 'title' => 'Avengers', 'price' => 8 })
theory_of_everything = Film.new({ 'title' => 'The Theory of Everything', 'price' => 11 })
fast_and_furious = Film.new({ 'title' => 'Fast and Furious', 'price' => 4 })

avengers.save()
theory_of_everything.save()
fast_and_furious.save()

ticket1 = Ticket.new({ 'customer_id' => harry.id, 'film_id' => avengers.id })
ticket2 = Ticket.new({ 'customer_id' => hermione.id, 'film_id' => theory_of_everything.id })
ticket3 = Ticket.new({ 'customer_id' => ron.id, 'film_id' => fast_and_furious.id })
ticket4 = Ticket.new({ 'customer_id' => harry.id, 'film_id' => fast_and_furious.id })
ticket5 = Ticket.new({ 'customer_id' => ron.id, 'film_id' => theory_of_everything.id })

ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()
ticket5.save()

screening1 = Screening.new({ 'time' => '18:00', 'film_id' => avengers.id, 'tickets' => 50 })
screening2 = Screening.new({ 'time' => '20:00', 'film_id' => theory_of_everything.id, 'tickets' => 10 })
screening3 = Screening.new({ 'time' => '21:30', 'film_id' => fast_and_furious.id, 'tickets' => 25 })
screening4 = Screening.new({ 'time' => '22:00', 'film_id' => fast_and_furious.id, 'tickets' => 38 })

screening1.save()
screening2.save()
screening3.save()
screening4.save()

binding.pry

nil