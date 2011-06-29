# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :line do |f|
  f.association :user
  f.association :shop
  f.association :item
  f.quantity 1
end
