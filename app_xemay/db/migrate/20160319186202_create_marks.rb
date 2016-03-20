class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
    	t.datetime :start_time
    	t.references :user, index: true, foreign_key: true
    	t.references :review, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
