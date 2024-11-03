class AddColorToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :color, :string
  end
end
