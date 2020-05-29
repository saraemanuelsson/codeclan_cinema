require_relative('../db/sql_runner')

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
        ( name, funds )
        VALUES
        ( $1, $2 )
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

end