# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :potential do |f|
  f.sequence(:name) { |n| "John #{n}" }
  f.email "asdf@gasdfa.com"
  f.address "MyString"
  f.phone "MyString"
  f.kind "restaurant"
end
