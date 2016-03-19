class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :content
      t.float :average_rating
      t.float :total_rating

      t.timestamps null: false
    end
  end
end
