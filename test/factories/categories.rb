Factory.define :category do |f|
  f.sequence(:name) { |n| "Category #{n}" }
  f.association :shop
end
