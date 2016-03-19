class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.datetime :time
      t.float :rating_point

      t.timestamps null: false
    end
  end
end
