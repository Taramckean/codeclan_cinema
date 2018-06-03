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

  def check_moviegoers()
    sql = "SELECT * from tickets where film_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    results.count()
  end

  def screening
    sql = "SELECT * from screenings"
    values = []
    screenings = SqlRunner.run(sql, values)
    result = screenings.map {|screening| Screening.new(screening)}
    return result
  end


  def most_popular_screening()
    sql = "SELECT screening_id
     FROM tickets
     GROUP BY screening_id
     ORDER BY COUNT(*)
     DESC
     LIMIT 1;"
    values = []
    results = SqlRunner.run(sql, values)[0]
    most_popular = Screening.find(results["screening_id"])
    return most_popular.showing
  end

#   SELECT TOP 1
#   name
# FROM
#   table
# GROUP BY
#   name
# ORDER BY
#   COUNT(name) DESC

  # SELECT       `column`
  #   FROM     `your_table`
  #   GROUP BY `column`
  #   ORDER BY COUNT(*) DESC
  #   LIMIT    1;

    # sql = "SELECT screening_id, COUNT(*) AS count FROM tickets
    # GROUP BY screening_id ORDER BY COUNT desc LIMIT 1"

    # # tickets array is an array of ticket objects for a given film.
    # screening1 = 0
    # screening2 = 0
    # screening3 = 0
    # for ticket in tickets
    #   if ticket.showing == '13:15'
    #     screening1 += 1
    #     if ticket.showing == '18:30'
    #       screening2 += 1
    #       if

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
