class Category < ApplicationRecord
  has_many :items

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
end
