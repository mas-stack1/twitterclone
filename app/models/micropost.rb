class Micropost < ApplicationRecord
  belongs_to :user
  has_many :reverses_of_favorites, class_name: "Favorite",foreign_key: "micropost_id"
  validates :content, presence: true, length: { maximum: 255 }
end
