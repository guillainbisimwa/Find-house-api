FactoryBot.define do
  factory :user do
    name { 'GBisimwa' }
    email { Faker::Internet.email }
    password_digest { '12345' }
  end
end
