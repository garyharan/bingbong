# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :item do |f|
  f.price "9.99"
  f.association :product
  f.association :size
end
