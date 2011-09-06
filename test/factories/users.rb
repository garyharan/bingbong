Factory.define :user do |f|
  f.sequence(:first_name) { |n| "John#{n}" }
  f.sequence(:last_name)  { |n| "Appleseed#{n}" }
  f.sequence(:email)      { |n| "gary.haran+test#{n}@example.com" }

  f.password              "this is fun"
end

Factory.define :confirmed_user, :parent => :user do |f|
  f.confirmed_at Time.now.utc
end

Factory.define :owner,  :parent => :confirmed_user do
end

Factory.define :client, :parent => :confirmed_user do
end
