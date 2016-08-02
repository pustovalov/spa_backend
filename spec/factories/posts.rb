FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.words(3).join(' ') }
    body { Faker::Lorem.words(10).join(' ') }
    username { Faker::Internet.user_name }
  end
end
