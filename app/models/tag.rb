class Tag < ApplicationRecord
    belongs_to :user
    belongs_to :tagging, polymorphic: true

end