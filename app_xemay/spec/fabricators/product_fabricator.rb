Fabricator(:product) do
  name {Faker::Hipster.sentence(2, true)}
  price {Faker::Number.number(3) + "000"}
end
