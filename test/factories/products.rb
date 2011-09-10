Factory.define :product do |f|
  f.sequence(:name) { |n| "Product #{n}" }
  f.association :category
end
