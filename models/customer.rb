require_relative("../db/sql_runner")

class Customer

attr_reader :id
attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT into customers (name, funds) VALUES ($1, $2) RETURNING id "
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  # def stars()
  #   sql = "SELECT stars.* FROM stars INNER JOIN castings ON stars.id =
  #   castings.star_id WHERE movie_id = $1"
  #   values = [@id]
  #   star_data = SqlRunner.run(sql, values)
  #   return Star.map_items(star_data)
  # end
  # # def movies()
  # #   sql = "SELECT movies.* FROM movies INNER JOIN castings
  #  ON movies.id = castings.movie_id WHERE star_id = $1"
  # #   values = [@id]
  # #   movie_data = SqlRunner.run(sql, values)
  # #   return Movie.map_items(movie_data)
  # # end

  def film()
    sql = "SELECT films.* from films INNER JOIN tickets on
    films.id = tickets.film_id WHERE customer_id = $1 "
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|result| Film.new(result)}
  end

  def delete()
    sql = "DELETE FROM customers where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * from customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map {|customer| Customer.new(customer)}
    return result
  end

  def update()
    sql = "UPDATE customers SET (name, funds) =
    ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end


end
