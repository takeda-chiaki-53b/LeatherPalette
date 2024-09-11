class ProductName < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }

  # アソシエーション
  belongs_to :product
end
