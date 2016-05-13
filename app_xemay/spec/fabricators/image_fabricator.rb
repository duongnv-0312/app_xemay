Fabricator(:image) do
  image {File.open(File.join(Rails.root, "app", "assets", "images", "motorcycle.png"))}
  caption {Faker::Lorem.sentence(3, true, 1)}
end
