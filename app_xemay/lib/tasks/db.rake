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
      avatar File.open(File.join(Rails.root, "app", "assets", "images", "avatar2.jpg"))
      role "admin"
    end

    Fabricate(:user) do
      name "Duong"
      email "duong@gmail.com"
      password "12345678"
      password_confirmation "12345678"
      avatar File.open(File.join(Rails.root, "app", "assets", "images", "avatar3.jpg"))
      role "admin"
    end

    puts "Creating User"
    30.times do
      Fabricate :user
    end

    puts "Creating Review"
    Fabricate :review do
      content "Tiệm sửa xe của Thành ở Cao Bá Quát, đối diện công ty môi trường đô thị.
        Em rất hài lòng về chất và divu, nhưng mỗi tội hơi đông nên nhiều khi phải để xe ở lại.
        Bác này sửa cả ga lẫn số, đều tốt cả."
      user_id 1
    end

    Fabricate :review do
      content "Bác Tuấn, Hàm Long đối diện trường Ngô Sĩ Liên có 1 hiệu em sửa 10 năm nay rồi,
        giá hợp lí, sửa cẩn thận uy tín.
        Chủ hiệu to béo luôn luôn mặc quần áo bộ đội"
      user_id 2
    end

    Fabricate :review do
      content "Cửa hàng sửa chữa xe máy Vinh Vinh 60 Tô Hiến Thành - Hà Nội
        Chuyên sửa chữa các loại xe phân khối lớn, phục chế các loại xe cổ"
      user_id 1
    end

    Fabricate :review do
      content "Cửa hàng sửa chữa xe máy Đình Thương 916 Đường Láng- Hà Nội
        Chuyên sửa chữa các dòng xe địa hình, thể thao, phân khối lớn."
      user_id 1
    end

    Fabricate :review do
      content "Cửa hàng Sửa chữa xe máy Sơn Còi 196 Phó Đức Chính - Ba Đình -HN.
        (phía sau cây xăng Hàng Bún - Yên Phụ)
        Sửa chữa xe ga và xe thời trang, đặc biệt là dòng xe Piagio."
      user_id 2
    end

    Fabricate :review do
      content "Cửa hàng sửa chữa xe máy của anh Thành Chung Địa chỉ 105B C9
        Tập thể Quỳnh Mai
        Chuyên sửa chữa, bảo dưỡng các loại xe ga, xe số"
      user_id 2
    end

    Fabricate :review do
      content "Cửa hàng sửa chữa xe máy Gia Sơn 99 Giảng Võ - Hà Nội
        Chuyên bảo dưỡng - gò hàn - Gia công cơ khí."
      user_id 2
    end

    Fabricate :review do
      content " Cửa hàng sửa chữa xe máy Gia Phong 107 Giảng Võ - Hà Nội
        Chuyên sửa chữa các loại xe ga, xe phổ thông, xe phân khối lớn"
      user_id 1
    end

    Fabricate :review do
      content "Cửa hàng sửa chữa xe máy Tân Hải 114 Đường Kim Giang (cạnh đền Lừ) - Hà Nội
        Chuyên sửa chữa các loại xe phổ thông"
      user_id 2
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

      Fabricate :image do
        image {File.open(File.join(Rails.root, "app", "assets", "images", "store1.jpg"))}
        store_id store.id
      end

      Fabricate :image do
        image {File.open(File.join(Rails.root, "app", "assets", "images", "store2.jpg"))}
        store_id store.id
      end

      Fabricate :image do
        image {File.open(File.join(Rails.root, "app", "assets", "images", "store3.jpg"))}
        store_id store.id
      end

      Fabricate :image do
        image {File.open(File.join(Rails.root, "app", "assets", "images", "store4.jpg"))}
        store_id store.id
      end

      5.times do
        Fabricate :product, store_id: store.id
      end
    end
  end
end
