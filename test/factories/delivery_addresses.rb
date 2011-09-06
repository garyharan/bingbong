Factory.define :delivery_address do |f|
  f.address       "1234 Any road, Any city"
  f.apartment     "1"
  f.city          "A City"
  f.zip_code      "a1a 1a1"
  f.phone_number  "123-456-7890"
  f.note          "Knock 3 times"

  f.association   :client
end
