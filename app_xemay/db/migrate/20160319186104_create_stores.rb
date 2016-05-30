class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :owner
      t.integer :store_type, default: 0
      t.float :avg_rating, default: 0
      t.integer :total_rater, default: 0

      t.references :review, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
