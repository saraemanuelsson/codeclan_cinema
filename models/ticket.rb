require_relative('../db/sql_runner')

class Ticket

    attr_accessor :customer_id, :film_id
    attr_reader :id 

    def initialize(options)
        @customer_id = options['customer_id'].to_i
        @film_id = options['film_id'].to_i
        @id = options['id'].to_i if options['id']
    end

    def self.delete_all()
        sql = "DELETE FROM tickets"
        SqlRunner.run(sql)
    end

end

