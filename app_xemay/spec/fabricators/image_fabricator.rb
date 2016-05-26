Fabricator(:image) do
  image {File.open(File.join(Rails.root, "app", "assets", "images", "store1.jpg"))}
  image {File.open(File.join(Rails.root, "app", "assets", "images", "store2.jpg"))}
  image {File.open(File.join(Rails.root, "app", "assets", "images", "store3.jpg"))}
end
