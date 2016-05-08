Fabricator(:image) do
  image {Faker::Avatar.image}
  caption {Faker::Lorem.sentence(3, true, 1)}
end
