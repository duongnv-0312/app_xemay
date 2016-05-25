Fabricator(:review) do
  content {Faker::Lorem.paragraph(3, true, 4)}
  user_id 1
end
