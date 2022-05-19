FactoryBot.define do
  factory :item do
    name { Faker::TvShows::AquaTeenHungerForce.character }
    description { Faker::TvShows::AquaTeenHungerForce.quote }
    unit_price { rand(100.00) }
  end
end
