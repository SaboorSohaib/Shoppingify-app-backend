class Item < ApplicationRecord
  belongs_to :list
  belongs_to :category

  validates :name, presence: true, length: { minimum: 4, maximum: 50 }
  validates :category_id, presence: true
  validates :list_id, presence: true
  validates :note, length: { maximum: 255 }
  validates :image, length: { maximum: 255 }
end
