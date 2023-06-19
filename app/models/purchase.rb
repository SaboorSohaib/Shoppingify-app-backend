class Purchase < ApplicationRecord
    belongs_to :item

    validates :item_id, presence: true
    validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :timestamp, presence: true
end
