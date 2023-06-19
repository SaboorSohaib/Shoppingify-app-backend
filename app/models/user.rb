class User < ApplicationRecord
    has_many :lists
    has_one :active_list, -> { where(active: true) }, class_name: 'List'

    validates :name, presence: true, length: { minimum: 4, maximum: 50 }
end
