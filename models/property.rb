require("pg")

class Property
  attr_accessor :address, :value, :number_of_bedrooms, :square_footage
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @address = options["address"]
    @value = options["value"]
    @number_of_bedrooms = options["number_of_bedrooms"]
    @square_footage = options["square_footage"]
  end

  def save()
    db = PG.connect({dbname:"property_tracker", host:"localhost"})

    sql = "INSERT INTO properties
      (address, value, number_of_bedrooms, square_footage)
      VALUES
      ($1, $2, $3, $4)
      RETURNING *"

    values = [@address, @value, @number_of_bedrooms, @square_footage]

    db.prepare("save",sql)
    @id= db.exec_prepared("save",values)[0]["id"].to_i
    db.close()
  end

  def delete()
    db = PG.connect({dbname: "property_tracker", host:"localhost"})

    sql = "DELETE FROM properties WHERE id = $1"

    values = [@id]

    db.prepare("delete_one",sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def update()

    db = PG.connect({dbname: "property_tracker", host:"localhost"})

    sql = "UPDATE properties SET
    (address, value, number_of_bedrooms, square_footage)
    =
    ($1, $2, $3, $4)
    WHERE id = $5"

    value = [@address, @value, @number_of_bedrooms, @square_footage,@id]

    db.prepare("update", sql)
    db.exec_prepared("update",value)
    db.close()
  end

  def Property.delete_all()
    db = PG.connect({dbname: "property_tracker", host:"localhost"})

  sql = "DELETE FROM properties"

  db.prepare("delete_all", sql)
  db.exec_prepared("delete_all")
  db.close()
  end

  def Property.all()
    db = PG.connect({dbname: "property_tracker", host:"localhost"})

  sql = "SELECT * FROM properties"

  db.prepare("all",sql) #(name, sql) name is the reference of the method.
  properties = db.exec_prepared("all")
  db.close()
  return properties.map{|property_hash|Property.new(property_hash)}
  end

  def Property.find(id)
    db = PG.connect({dbname: "property_tracker", host:"localhost"})

    sql = "Select * FROM properties WHERE id = $1"
    values = [id]
    db.prepare("find",sql)
    result = db.exec_prepared("find",values)
    db.close()
    return result.map{|result_hash|Property.new(result_hash)}
  end

  def Property.find_by_address(address)
    db = PG.connect({dbname: "property_tracker", host:"localhost"})

    sql = "Select * FROM properties WHERE address = '$1'"
    values = [address]
    db.prepare("find_by_address",sql)
    result = db.exec_prepared("find_by_address")
    db.close()
    return result.map{|result_hash|Property.new(result_hash)}
  end
end
