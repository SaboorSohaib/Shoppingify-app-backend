class Item < ApplicationRecord
  belongs_to :list, optional: true
  belongs_to :category

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :category_id, presence: true
end
