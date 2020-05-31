require_relative('../db/sql_runner')

class Screening

    attr_accessor :time, :film_id, :capacity, :tickets_sold
    attr_reader :id

    def initialize(options)
        @time = options['time']
        @film_id = options['film_id'].to_i
        @capacity = options['capacity'].to_i
        @tickets_sold = 0
        @id = options['id'].to_i if options['id']
    end

    def save()
        sql = "INSERT INTO screenings
        ( time, film_id, capacity, tickets_sold )
        VALUES
        ( $1, $2, $3, $4 )
        RETURNING id"
        values = [@time, @film_id, @capacity, @tickets_sold ]
        id = SqlRunner.run(sql, values)[0]['id']
        @id = id.to_i
    end

    def update()
        sql = "UPDATE screenings SET
        ( time, film_id, capacity, tickets_sold )
        =
        ( $1, $2, $3, $4 )
        WHERE id = $5"
        values = [@time, @film_id, @capacity, @tickets_sold, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM screenings
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end
    
    def film()
        sql = "SELECT films.* FROM films
        INNER JOIN screenings
        ON films.id = screenings.film_id
        WHERE screenings.id = $1"
        values = [@id]
        film_data = SqlRunner.run(sql, values)[0]
        return Film.new(film_data)
    end

    def increase_tickets_sold()
        @tickets_sold += 1
        update()
    end

    def self.all()
        sql = "SELECT * FROM screenings"
        screenings = SqlRunner.run(sql)
        return Screening.map_items(screenings)
    end

    def self.delete_all()
        sql = "DELETE FROM screenings"
        SqlRunner.run(sql)
    end

    def self.map_items(screening_data)
        screening_data.map { |screening| Screening.new(screening) }
    end

end