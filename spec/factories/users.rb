FactoryBot.define do
  factory :user do
    name { 'GBisimwa' }
    email { 'guy@me.com'}
    password_digest { '12345' }
  end
end
