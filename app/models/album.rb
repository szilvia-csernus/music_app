class Album < ApplicationRecord

    validates :title, :year, presence: :true

    belongs_to :band
    has_many :tracks, dependent: :destroy
    has_many :tags, as: :tagging, dependent: :destroy
end
