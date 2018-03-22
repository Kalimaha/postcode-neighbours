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

Listing.create(address: Faker::Address.street_address, suburb: 'Jan Juc', lon: 144.3004349, lat: -38.3470702)
Listing.create(address: Faker::Address.street_address, suburb: 'Jan Juc', lon: 144.2870525, lat: -38.3510259)
Listing.create(address: Faker::Address.street_address, suburb: 'Bellbrae', lon: 144.2587945, lat: -38.3383703)
Listing.create(address: Faker::Address.street_address, suburb: 'Connewarre', lon: 144.4553598, lat: -38.2742371)
Listing.create(address: Faker::Address.street_address, suburb: 'Connewarre', lon: 144.4562976, lat: -38.2738287)
Listing.create(address: Faker::Address.street_address, suburb: 'Connewarre', lon: 144.4689928, lat: -38.2342086)
Listing.create(address: Faker::Address.street_address, suburb: 'Breamleai', lon: 144.3892843, lat: -38.2960857)
Listing.create(address: Faker::Address.street_address, suburb: 'Breamleai', lon: 144.3865818, lat: -38.2970821)
Listing.create(address: Faker::Address.street_address, suburb: 'Freshwater Creek', lon: 144.2191901, lat: -38.2651842)
Listing.create(address: Faker::Address.street_address, suburb: 'Freshwater Creek', lon: 144.2658382, lat: -38.2701955)
Listing.create(address: Faker::Address.street_address, suburb: 'Torquay', lon: 144.3165742, lat: -38.3333263)
Listing.create(address: Faker::Address.street_address, suburb: 'Torquay', lon: 144.3072339, lat: -38.3323602)
Listing.create(address: Faker::Address.street_address, suburb: 'Torquay', lon: 144.3199736, lat: -38.3320501)
