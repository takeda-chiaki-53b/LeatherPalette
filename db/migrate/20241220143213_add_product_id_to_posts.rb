class AddProductIdToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :product_id, :integer
    add_index :posts, :product_id
  end
end
