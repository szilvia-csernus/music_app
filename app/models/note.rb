class Note < ApplicationRecord
    validates :text, :track_id, :user_id, presence: true

    belongs_to :track
    belongs_to :user

    delegate :email, to: :user, prefix: true
end
