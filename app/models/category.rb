class Category < ApplicationRecord
  has_many :items

  validates :name, presence: true, length: { minimum: 4, maximum: 50 }
end
