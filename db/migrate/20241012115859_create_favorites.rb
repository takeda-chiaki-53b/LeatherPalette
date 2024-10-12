class CreateFavorites < ActiveRecord::Migration[7.2]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
    # 特定のユーザー(user_id)と投稿(post_id)の組み合わせに対して一意であることを保証=重複するお気に入りの登録を防ぐ。
    add_index :favorites, [ :user_id, :post_id ], unique: true
  end
end
