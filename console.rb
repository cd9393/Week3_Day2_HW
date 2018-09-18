require("pry")
require_relative("./models/property")

Property.delete_all()

property1 = Property.new({ 'address' => "1 Broomlands Avenue",
  'value' => 250000,
  'number_of_bedrooms' => 5,
  'square_footage' => 30000})

property2 = Property.new({ 'address' => "2 Renfield Avenue",
    'value' => 550000,
    'number_of_bedrooms' => 10,
    'square_footage' => 300000})

    property1.save()
    property2.save()

    # property2.delete()

    property1.value = 10000
    property1.update()

    result_id = Property.find(property1.id) # using property1.id will return the property regardless of where it is.
    result = Property.find_by_address("2 Renfrew Avenue")
binding.pry
nil
