FactoryBot.define do
  factory :album, parent: :band do
    title { Faker::Music.unique.album }
    year { Faker::Number.within(range: 1900..2020) }
    live { Faker::Boolean.boolean }
    association :band
  end

  # factory :album_with_tracks do
  #     transient do
  #       tracks_count { 5 }
  #     end

  #     tracks do
  #       Array.new(tracks_count) { association(:track) }
  #     end
  #   end

end


# create(:album_with_tracks).tracks.length # 5
# create(:album_with_tracks, tracks_count: 15).tracks.length # 15
# build(:album_with_tracks, tracks_count: 15).tracks.length # 15
# build_stubbed(:album_with_tracks, tracks_count: 15).tracks.length # 15

# create(:tag)
# create(:tag, :for_album)
