FactoryBot.define do
  factory :track, parent: :album do
    title { Faker::Music::Prince.song}
    ord { Faker::Number.within(range: 1..20)}
    bonus {Faker::Boolean.boolean}
    lyrics {Faker::Music::Prince.lyric}
  end

end

# create(:tag)
# create(:tag, :for_track)
