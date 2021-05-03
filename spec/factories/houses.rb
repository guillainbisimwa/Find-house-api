FactoryBot.define do
  factory :house do
    price { '200' }
    details { 'Details Here' }
    about { 'About my house' }
    picture { 'url to pic' }
    owner { 'Guy' }
  end
end
