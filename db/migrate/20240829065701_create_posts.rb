class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.text :body, null: false

      t.timestamps
    end
  end
end
