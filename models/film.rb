require_relative("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options ['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT into films (title, price) VALUES ($1, $2) returning id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def customer()
    sql = "SELECT customers.* from customers INNER JOIN tickets on
    customers.id = tickets.customer_id WHERE film_id = $1 "
    values = [@id]
    results = SqlRunner.run(sql, values)
    results.map {|result| Customer.new(result)}
  end

  def delete()
    sql = "DELETE FROM films where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    values = []
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * from films"
    values = []
    films = SqlRunner.run(sql, values)
    result = films.map {|film| Film.new(film)}
    return result
  end

  def update()
    sql = "UPDATE films SET (title, price) =
    ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

end
