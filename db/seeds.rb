# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do 
    Band.create(name: Faker::Music.band)
end

20.times do
    Album.create(title: Faker::Music.unique.album, year: Faker::Number.within(range: 1900..2020), 
    live: Faker::Boolean.boolean, band_id: Faker::Number.within(range: 7..16))
end

80.times do
    Track.create(title: Faker::Music::Phish.song, ord: Faker::Number.within(range: 1..20), 
    bonus: Faker::Boolean.boolean, album_id: Faker::Number.within(range: 10..31))

end