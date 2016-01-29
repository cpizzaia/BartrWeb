FactoryGirl.define do
  factory :item do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    image { Faker::Avatar.image }
  end
end
