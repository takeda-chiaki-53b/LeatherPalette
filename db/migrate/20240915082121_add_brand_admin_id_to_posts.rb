class AddBrandAdminIdToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :brand_admin_id, :integer
    add_index :posts, :brand_admin_id
  end
end
