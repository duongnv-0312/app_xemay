class AddStoreIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :store_id, :integer
  end
end
