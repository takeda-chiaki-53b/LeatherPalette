class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { message: "：このユーザー名は使用できません。別の名前をご入力ください。" }
  validates :email, presence: true, uniqueness: { message: "：このメールアドレスは使用できません。別のメールアドレスをご入力ください。" }
  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true

  # 権限判定用
  enum role: { general: 0, brand_admin: 1, app_admin: 2 }

  # アソシエーション
  has_many :posts, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :favorites, dependent: :destroy # ユーザーが複数のお気に入りを持つことを定義
  has_many :favorite_posts, through: :favorites, source: :post # そのお気に入りを通じて関連する投稿を取得する定義
  # これにより、ユーザーがお気に入り登録した全ての投稿を user.favorite_posts というメソッドで簡単に取得できるようになる。
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

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
