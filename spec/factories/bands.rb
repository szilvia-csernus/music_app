FactoryBot.define do
  factory :band do
    name { Faker::Music.unique.band}
    end

  # factory :band_with_albums do
  #   transient do
  #     albums_count { 5 }
  #   end

  #   albums do
  #     Array.new(albums_count) { association(:album) }
  #   end
  # end

end


# create(:band_with_albums).albums.length # 5
# create(:band_with_albums, albums_count: 15).albums.length # 15
# build(:band_with_albums, albums_count: 15).albums.length # 15
# build_stubbed(:band_with_albums, albums_count: 15).albums.length # 15

# create(:tag)
# create(:tag, :for_band)
