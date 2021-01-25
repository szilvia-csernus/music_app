FactoryBot.define do
  factory :tag, parent: :user do
      trait :for_band do
        association :tags, factory: :band
      end

      trait :for_album do
        association :tags, factory: :album
      end

      trait :for_track do
        association :tags, factory: :track
      end

  end
end

# create(:tag)
# create(:tag, :for_track)
