Fabricator(:coordinate) do
  lat {Faker::Number.between(20.99, 21.06)}
  lng {Faker::Number.between(105.7, 105.9)}
  region_id {Faker::Number.between(1, 4)}
end
