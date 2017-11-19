require_relative("../db/sql_runner")


class Ticket

  attr_accessor :customer_id, :film_id, :id

  def initialize( options )
    @id = options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets
    (
      customer_id,
      film_id
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run( sql,values ).first
    @id = ticket['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    values = []
    ticket = SqlRunner.run(sql, values)
    result = ticket.map { |ticket| Ticket.new( ticket ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    values = []
    SqlRunner.run(sql, values)
  end

  def customer() #returning a customer object need to get relevent data
    sql = "SELECT * FROM customers WHERE id = $1" #$1 is customer_id
    values =[@customer_id]
    customer = SqlRunner.run(sql, values).first #customer is a hash in a array. gem always gives back results as an array. [id name category]
    return Customer.new(customer)
  end

  def film()
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@film_id]
    film = SqlRunner.run(sql, values).first #first pops in out the array so its just a hash
    return Film.new(film)
  end


  # def customers_attending()
  #   sql = "SELECT * FROM tickets WHERE film_id = 1"
  #   values = [@customer_id]
  #   customer = SqlRunner.run(sql, values).first #first pops in out the array so its just a hash
  #   return Ticket.new(customer)
  # end

  # def update()
  #   sql = "UPDATE tickets
  #   SET
  #   (
  #     title,
  #     price
  #   ) =
  #   (
  #     $1, $2
  #   )
  #   WHERE id = $3"
  #   values = [@title, @price, @id]
  #   customers = SqlRunner.run(sql, values)
  # end

end
