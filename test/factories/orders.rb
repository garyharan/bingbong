# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :order do |f|
  f.association :user
  f.association :shop
  f.address "135 Bellevista Dr"
  f.appartment "2b"
  f.phone_number "555-555-5555"
  f.note "Please wait a while after ringing"
end
