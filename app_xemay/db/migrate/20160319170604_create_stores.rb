class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :owner

      t.timestamps null: false
    end
  end
end
