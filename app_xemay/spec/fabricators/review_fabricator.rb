Fabricator(:review) do
  content {Faker::Lorem.paragraph(3, true, 4)}
  user_id {Faker::Number.between(1, 30)}
end
