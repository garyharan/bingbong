# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :order do |f|
  f.association :user
  f.association :shop
end
