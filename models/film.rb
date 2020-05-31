require_relative('../db/sql_runner')
require_relative('./customer')
require_relative('./screening')

class Film

    attr_accessor :title, :price
    attr_reader :id

    def initialize(options)
        @title = options['title']
        @price = options['price'].to_i
        @id = options['id'].to_i if options['id']
    end

    def save()
        sql = "INSERT INTO films
        ( title, price)
        VALUES
        ( $1, $2 )
        RETURNING id"
        values = [@title, @price]
        id = SqlRunner.run(sql, values)[0]['id']
        @id = id.to_i
    end

    def update()
        sql = "UPDATE films SET
        ( title, price )
        =
        ( $1, $2 )
        WHERE id = $3"
        values = [@title, @price, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM films
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def customers()
        sql = "SELECT customers.* FROM customers
        INNER JOIN tickets
        ON customers.id = tickets.customer_id
        INNER JOIN films
        ON tickets.film_id = films.id
        WHERE film_id = $1"
        values = [@id]
        customers = SqlRunner.run(sql, values)
        return Customer.map_items(customers)
    end

    def screenings()
        sql = "SELECT screenings.* FROM screenings
        INNER JOIN films
        ON screenings.film_id = films.id
        WHERE film_id = $1"
        values = [@id]
        screenings = SqlRunner.run(sql, values)
        return Screening.map_items(screenings)
    end

    def most_popular_screening_time()
        movies_by_tickets = screenings.sort_by{ |time, film_id, capacity, tickets_sold| tickets_sold }
        return movies_by_tickets.first
    end

    def number_of_customers_watching()
        result = customers.size
        return result
    end

    def self.all()
        sql = "SELECT * FROM films"
        films = SqlRunner.run(sql)
        return Film.map_items(films)
    end

    def self.delete_all()
        sql = "DELETE FROM films"
        SqlRunner.run(sql)
    end

    def self.map_items(film_data)
        return film_data.map { |film| Film.new(film) }
    end

end