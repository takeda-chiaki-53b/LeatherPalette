class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  # 権限判定用
  enum role: { general: 0, brand_admin: 1, app_admin: 2 }

  # アソシエーション
  has_many :posts, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :favorites, dependent: :destroy # ユーザーが複数のお気に入りを持つことを定義
  has_many :favorite_posts, through: :favorites, source: :post # そのお気に入りを通じて関連する投稿を取得する定義
  # これにより、ユーザーがお気に入り登録した全ての投稿を user.favorite_posts というメソッドで簡単に取得できるようになる。

  # スコープ
  scope :brand_admins, -> { where(role: "brand_admin") }

  # オブジェクトの user_idがユーザーオブジェクトのidと一致するかどうかを判定
  def own?(object)
    id == object&.user_id
  end

  # お気に入りに追加する
  def favorite(post)
    favorite_posts << post
  end

  # お気に入りを外す
  def unfavorite(post)
    favorite_posts.destroy(post)
  end

  # お気に入り登録をしているか判定する
  def favorite?(post)
    favorite_posts.include?(post)
  end
end
