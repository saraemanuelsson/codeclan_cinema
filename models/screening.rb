require_relative('../db/sql_runner')

class Screening

    attr_accessor :time, :film_id, :tickets
    attr_reader :id

    def initialize(options)
        @time = options['time']
        @film_id = options['film_id'].to_i
        @tickets = options['tickets'].to_i
        @id = options['id'].to_i if options['id']
    end

    def save()
        sql = "INSERT INTO screenings
        ( time, film_id, tickets )
        VALUES
        ( $1, $2, $3 )
        RETURNING id"
        values = [@time, @film_id, @tickets]
        id = SqlRunner.run(sql, values)[0]['id']
        @id = id.to_i
    end

    def update()
        sql = "UPDATE screenings SET
        ( time, film_id, tickets )
        =
        ( $1, $2, $3 )
        WHERE id = $4"
        values = [@name, @film_id, @tickets, $id]
        SqlRunner.run(sql, values)
    end

    def self.delete_all()
        sql = "DELETE FROM screenings"
        SqlRunner.run(sql)
    end


end