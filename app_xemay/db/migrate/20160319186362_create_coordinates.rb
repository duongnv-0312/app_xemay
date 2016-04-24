class CreateCoordinates < ActiveRecord::Migration
  def change
    create_table :coordinates do |t|
      t.decimal :lat, precision: 32, scale: 14
      t.decimal :lng, precision: 32, scale: 14
      t.references :region, index: true, foreign_key: true
      t.references :store, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
