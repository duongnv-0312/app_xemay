Fabricator(:store) do
  name {Faker::Lorem.sentence(3, false, 6)}
  address {Faker::Address.street_address}
  phone_number {Faker::PhoneNumber.phone_number}
  owner {Faker::Name.name}
end
