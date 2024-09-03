class Post < ApplicationRecord
  mount_uploader :post_image, PostImageUploader

  validates :post_image, length: { maximum: 5 }
  validates :body, presence: true, length: { maximum: 65_535 }

  # アソシエーション
  belongs_to :user
end
