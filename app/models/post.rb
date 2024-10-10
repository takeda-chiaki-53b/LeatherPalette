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

  # 投稿のステータス（下書き,公開,非公開）
  enum status: { draft: 0, published: 1, unpublished: 2 }

  # ステータスごとに投稿を取得するスコープ
  scope :published, -> { where(status: :published) }
  scope :unpublished, -> { where(status: :unpublished) }
  scope :draft, -> { where(status: :draft) }
end
