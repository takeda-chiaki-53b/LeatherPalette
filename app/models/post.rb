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
end
