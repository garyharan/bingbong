Factory.define :size do |f|
  f.sequence(:name) { |n| "Medium #{n}" }
  f.price "#{rand(15)}.#{rand(9)}#{rand(9)}"
end
