Factory.define :product do |f|
  f.sequence(:name) { |n| "Product #{n}" }
end
