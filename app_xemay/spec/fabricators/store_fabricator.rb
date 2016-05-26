Fabricator(:store) do
  name {Faker::Lorem.sentence(3, false, 6)}
  address {Faker::Address.street_address}
  phone_number {Faker::Number.between(1000000, 9000000)}
  owner {Faker::Name.name}
  avg_rating 0
  total_rater 0
end
