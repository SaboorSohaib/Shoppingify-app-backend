class List < ApplicationRecord
    belongs_to :user
    has_many :items
    has_many :purchases, through: :items

    validates :user_id, uniqueness: { scope: :active, message: 'User can have only one active list' }
    validates :name, presence: true, length: { minimum: 4, maximum: 50 }
end
