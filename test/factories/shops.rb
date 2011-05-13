Factory.define :shop do |f|
  f.sequence(:name)          { |n| "My Shop #{n}" }
  f.sequence(:phone_number)  { |n| "555-555-#{n.to_s.rjust(4, '0')}" }
  f.city "Saint-Hubert"
  f.address "1514 Murray Street"
  f.province "Quebec"
  f.country "Canada"
  f.postal_code "J4T1C7"
  f.latitude "45.00000"
  f.longitude "73.0000"
end
