# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :order do |f|
  f.user_id 1
  f.shop_id 1
  f.address "135 Bellevista Dr"
  f.appartment "2b"
  f.phone_number "555-555-5555"
  f.note "Please wait a while after ringing"
end
