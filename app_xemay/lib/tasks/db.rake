namespace :db do
  desc "Remake database data"
  task remake_data: :environment do
    Rake::Task["db:migrate:reset"].invoke

    puts "Creating Admin"
    Fabricate(:user) do
      name "User0"
      email "admin@gmail.com"
      password "12345678"
      password_confirmation "12345678"
      role "admin"
    end

    puts "Creating User"
    30.times do
      Fabricate :user
    end

    puts "Creating Review"
    30.times do
      Fabricate :review
    end

    puts "Creating Store"
    Review.all.each do |review|
      Fabricate :store, review_id: review.id
    end

    puts "Creating Region"
    ["Hà Nội", "Vĩnh Phúc", "Hưng Yên", "Hà Nam"].each do |name|
      Fabricate :region, name: name
    end

    puts "Creating Image, Coordinate, Product"
    Store.all.each do |store|
      Fabricate :coordinate, store_id: store.id

      2.times do
        Fabricate :image, store_id: store.id
      end

      5.times do
        Fabricate :product, store_id: store.id
      end
    end
  end
end
