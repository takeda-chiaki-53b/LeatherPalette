class CreateProductNames < ActiveRecord::Migration[7.2]
  def change
    create_table :product_names do |t|
      t.string :name,             null: false
      t.timestamps
    end
  end
end
