class Post < ApplicationRecord
  mount_uploaders :post_image, PostImageUploader

  validates :post_image, length: { maximum: 5 }
  validates :body, presence: true, length: { maximum: 65_535 }

  # アソシエーション
  belongs_to :user
  belongs_to :brand_admin, class_name: "User", optional: true
  has_many :products
end
