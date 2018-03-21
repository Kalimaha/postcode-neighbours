require 'faker'

Faker::Config.locale = 'en-AU'

100.times do
  Listing.create(
    address: Faker::Address.street_address,
    suburb: Faker::Address.suburb,
    lat: Faker::Address.latitude,
    lon: Faker::Address.longitude
  )
end
