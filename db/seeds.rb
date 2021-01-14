# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Band.destroy_all

Band.create(name: "Prince")

10.times do 
    Band.create(name: Faker::Music.band)
end

20.times do
    Album.create(title: Faker::Music::Prince.unique.album, year: Faker::Number.within(range: 1900..2020), 
    live: Faker::Boolean.boolean, band_id: Band.find_by(name: "Prince").id)
end

100.times do
    Track.create(title: Faker::Music::Prince.song, ord: Faker::Number.within(range: 1..20), 
    bonus: Faker::Boolean.boolean, lyrics: Faker::Music::Prince.lyric, album_id: Faker::Number.within(range: 1..20))

end