# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :size do |f|
  f.sequence(:name) { |n| "#{n} inches" }
end
