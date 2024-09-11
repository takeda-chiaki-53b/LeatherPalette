class Product < ApplicationRecord
  validates :product_image, length: { maximum: 1 }

  # アソシエーション
  belongs_to :user
  belongs_to :post
  has_many :product_names
end
