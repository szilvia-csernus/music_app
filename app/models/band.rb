class Band < ApplicationRecord
    validates :name, presence: true

    has_many :albums, dependent: :destroy
    has_many :tags, as: :tagging, dependent: :destroy
end