class Post < ApplicationRecord
  validates :body, presence: true, length: { maximum: 65_535 }

  # アソシエーション
  belongs_to :user
end
