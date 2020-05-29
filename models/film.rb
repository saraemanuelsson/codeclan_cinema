require_relative('./db/sql_runner')

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

end