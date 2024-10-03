class AddCareColumnsToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :care_item, :string
    add_column :posts, :care_frequency, :string
    add_column :posts, :care_howto, :text
  end
end
