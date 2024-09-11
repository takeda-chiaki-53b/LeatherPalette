class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.json :product_image

      t.timestamps
    end
  end
end
