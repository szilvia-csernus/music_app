class Track < ApplicationRecord

    validates :title, :ord, presence: true

    belongs_to :album
    has_many :notes, dependent: :destroy
    has_many :tags, as: :tagging, dependent: :destroy

    delegate :band_name, to: :album, prefix: true  # allows to use #album_band_name
end
