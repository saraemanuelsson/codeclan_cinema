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

    def self.delete_all()
        sql = "DELETE FROM screenings"
        SqlRunner.run(sql)
    end


end