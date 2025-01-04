class Product < ApplicationRecord
  mount_uploader :product_image, ProductImageUploader

  validates :product_name, presence: true, length: { maximum: 30 }

  # アソシエーション
  belongs_to :user
  belongs_to :post, optional: true
end
