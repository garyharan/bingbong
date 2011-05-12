# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :order do |f|
  f.state "MyString"
  f.user_id 1
  f.shop_id 1
end