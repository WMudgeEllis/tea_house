FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Lorem.paragraph }
    temperature { Faker::Number.number(digits: 2) }
    brew_time { Faker::Number.decimal(l_digits: 2) }
  end
end
