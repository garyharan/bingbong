# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :order do |f|
  f.association :delivery_address
  f.association :shop
  f.sequence(:validation_code) { |i| "validation code #{i}" }
end
