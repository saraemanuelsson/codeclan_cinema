require_relative('../db/sql_runner')
require_relative('./film')
require_relative('./ticket')

class Customer

    attr_accessor :name, :funds
    attr_reader :id

    def initialize(options)
        @name = options['name']
        @funds = options['funds'].to_i
        @id = options['id'].to_i if options['id']
    end

    def save()
        sql = "INSERT INTO customers
        (name, funds)
        VALUES
        ($1, $2 )
        RETURNING id"
        values = [@name, @funds]
        id = SqlRunner.run(sql, values)[0]['id']
        @id = id.to_i
    end

    def update()
        sql = "UPDATE customers SET
        ( name, funds )
        =
        ( $1, $2 )
        WHERE id = $3"
        values = [@name, @funds, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM customers
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def films()
        sql = "SELECT films.* FROM films
        INNER JOIN tickets
        ON films.id = tickets.film_id
        INNER JOIN customers
        ON tickets.customer_id = customers.id
        WHERE customer_id = $1"
        values = [@id]
        films = SqlRunner.run(sql, values)
        return Film.map_items(films)
    end

    def decrease_funds(amount)
        return @funds -= amount
        save()
    end

    def buy_ticket(film)
        price = film.price
        decrease_funds(price)
        new_ticket = Ticket.new({'customer_id' => @id, 'film_id' => film.id })
        new_ticket.save()
    end

    def number_of_tickets_bought()
        result = films.size()
        return result
    end

    def self.all()
        sql = "SELECT * FROM customers"
        customers = SqlRunner.run(sql)
        return Customer.map_items(customers)
    end

    def self.delete_all()
        sql = "DELETE FROM customers"
        SqlRunner.run(sql)
    end

    def self.map_items(customer_data)
        return customer_data.map { |customer| Customer.new(customer) }
    end

end