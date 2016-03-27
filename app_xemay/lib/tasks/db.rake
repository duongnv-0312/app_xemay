namespace :db do
  desc "Remake database data"
  task remake_data: :environment do
    Rake::Task["db:migrate:reset"].invoke

    puts "Creating User"
    30.times do
      Fabricate :user
    end
  end
end
