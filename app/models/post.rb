class Post < ApplicationRecord
  mount_uploaders :post_image, PostImageUploader

  validates :post_image, length: { maximum: 5 }
  validates :body, presence: true, length: { maximum: 2000 }
  validates :care_item, length: { maximum: 700 }
  validates :care_howto, length: { maximum: 1000 }

  # アソシエーション
  belongs_to :user
  belongs_to :brand_admin, class_name: "User", optional: true
  has_many :products
  has_many :favorites, dependent: :destroy

  # 投稿のステータス（下書き,公開,非公開）
  enum status: { draft: 0, published: 1, unpublished: 2 }

  # ステータスごとに投稿を取得するスコープ
  scope :published, -> { where(status: :published) }
  scope :unpublished, -> { where(status: :unpublished) }
  scope :draft, -> { where(status: :draft) }

  # 検索画面に関するスコープ
  # 指定のブランドをbrand_admin_idカラムに含む投稿を取得する
  scope :brand_post_search, ->(brand_admin_id) { where(brand_admin_id: brand_admin_id, status: :published) }
  # 選択した使用年数を含み、且つ公開ステータスの投稿を取得
  scope :used_year_post_search, ->(used_year) { where(used_year: used_year, status: :published) }
  # 選択したカラーを含み、且つ公開ステータスの投稿を取得
  scope :color_post_search, ->(color) { where(color: color, status: :published) }
end
