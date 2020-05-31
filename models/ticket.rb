require_relative('../db/sql_runner')

class Ticket

    attr_accessor :customer_id, :film_id, :screening_id
    attr_reader :id 

    def initialize(options)
        @customer_id = options['customer_id'].to_i
        @film_id = options['film_id'].to_i
        @screening_id = options['screening_id'].to_i
        @id = options['id'].to_i if options['id']
    end

    def save()
        sql = "INSERT INTO tickets
        ( customer_id, film_id, screening_id )
        VALUES
        ( $1, $2, $3 )
        RETURNING id"
        values = [@customer_id, @film_id, @screening_id]
        id = SqlRunner.run(sql, values)[0]['id']
        @id = id.to_i
    end

    def update()
        sql = "UPDATE tickets SET
        ( customer_id, film_id, screening_id )
        =
        ( $1, $2, $3 )
        WHERE id = $4"
        values = [@customer_id, @film_id, @screening_id, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM tickets
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.all()
        sql = "SELECT * FROM tickets"
        tickets = SqlRunner.run(sql)
        return Ticket.map_items(tickets)
    end

    def self.delete_all()
        sql = "DELETE FROM tickets"
        SqlRunner.run(sql)
    end

    def self.map_items(ticket_data)
        return ticket_data.map { |ticket| Ticket.new(ticket) }
    end

end

