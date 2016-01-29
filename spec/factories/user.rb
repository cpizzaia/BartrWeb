FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    password { Faker::Internet.password }
    location { Faker::Address.latitude + " " + Faker::Address.longitude  }
  end
end
