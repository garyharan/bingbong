Factory.define :user do |f|
  f.sequence(:first_name)    { |n| "John#{n}" }
  f.sequence(:last_name)     { |n| "Appleseed#{n}" }
  f.sequence(:email)         { |n| "john#{n}@example.com" }
  f.password "this is fun"
end
