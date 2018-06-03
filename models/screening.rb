require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor :showing, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @showing = options['showing']
    @film_id = options['film_id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    values = []
    SqlRunner.run(sql, values)
  end

  def save()
    sql = "INSERT into screenings (showing, film_id)
    VALUES ($1, $2) returning id"
    values = [@showing, @film_id]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i
  end

  def self.find(id)
    sql = "SELECT * FROM screenings WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    screening = self.new(result.first)
    return screening
  end

end
