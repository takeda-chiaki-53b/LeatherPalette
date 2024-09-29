class AddUsedYearToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :used_year, :string
  end
end
