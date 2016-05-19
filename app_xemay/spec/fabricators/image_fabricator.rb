Fabricator(:image) do
  image {File.open(File.join(Rails.root, "app", "assets", "images", "motorcycle.png"))}
end
