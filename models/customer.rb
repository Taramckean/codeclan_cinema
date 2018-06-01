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

  def buy_ticket(film)
    @funds -= film.price
  end

  def count_tickets()
    sql = "SELECT * from tickets where customer_id = $1 "
    values = [@id]
    results = SqlRunner.run(sql, values)
    results.count()
  end

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
