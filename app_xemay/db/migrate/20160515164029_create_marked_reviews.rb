class CreateMarkedReviews < ActiveRecord::Migration
  def change
    create_table :marked_reviews do |t|
      t.references :user, index: true, foreign_key: true
      t.references :review, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
