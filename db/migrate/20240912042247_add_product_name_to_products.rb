class AddProductNameToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :product_name, :string, null: false
  end
end
