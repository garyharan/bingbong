Factory.define :user do |f|
  f.sequence(:first_name) { |n| "John#{n}" }
  f.sequence(:last_name)  { |n| "Appleseed#{n}" }
  f.sequence(:email)      { |n| "gary.haran+test#{n}@example.com" }

  f.confirmed_at          Time.now.utc

  f.password              "this is fun"
end
