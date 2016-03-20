class CreateCoordinates < ActiveRecord::Migration
  def change
    create_table :coordinates do |t|
      t.float :lat
      t.float :lng
      t.references :region, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
