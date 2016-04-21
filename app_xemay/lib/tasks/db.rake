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
  end
end
