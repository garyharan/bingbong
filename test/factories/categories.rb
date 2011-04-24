Factory.define :category do |f|
  f.sequence(:name) { |n| "Category #{n}" }
end
