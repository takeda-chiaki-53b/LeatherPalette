class Favorite < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :post

  # user_idが特定のpost_idに対してユニークであることを確認する＝同じpost_idの中で、同じuser_idが重複しないことを保証する。
  # ユーザーが特定の投稿に対して1回だけアクションを行うことを許可するため。
  validates :user_id, uniqueness: { scope: :post_id }
end
