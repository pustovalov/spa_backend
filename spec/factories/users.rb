FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Lorem.word }
    password_digest { Faker::Lorem.word }
    locale 'en'
  end
end
