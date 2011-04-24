Factory.define :shop do |f|
  f.sequence(:name)          { |n| "My Shop #{n}" }
  f.sequence(:phone_number)  { |n| "555-555-#{n.to_s.rjust(4, '0')}" }
  f.city "Dartmouth"
  f.address "150 Woodland Avenue"
  f.province "Nova Scotia"
  f.country "Canada"
  f.postal_code "B2W 2X6"
end
