Fabricator(:review) do
  content {Faker::Lorem.paragraph(3, true, 4)}
  average_rating {Faker::Number.between(1, 10)}
  total_rating {Faker::Number.between(20, 100)}
  user_id {Faker::Number.between(1, 30)}
end
