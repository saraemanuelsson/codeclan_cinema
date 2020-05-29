require('pg')

class SqlRunner

    def self.run(sql, values = [])
        begin
            db = PG.connect({ dbname: 'codeclan_cinema', host: 'localhost' })
            db.prepare('query', sql)
            result = db.exec_prepare('query', values)
        ensure
            db.close() if db != nil
        end
        return
    end
end