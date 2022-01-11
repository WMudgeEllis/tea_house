FactoryBot.define do
  factory :subscription do
    title { Faker::Lorem.word }
    price { Faker::Number.number(digits: 4) }
    frequency { Faker::Number.number(digits: 2) }
    status { 1 }
  end
end
