require 'rails_helper'

RSpec.describe ListingsRepository do
  describe '.find_by_suburb' do
    subject(:find_by_suburb)   { described_class.find_by_suburb(suburb: suburb) }

    let(:suburb)               { 'Torquay' }
    let(:neighbouring_suburb)  { 'Jan Juc' }
    let(:far_away_suburb)      { 'Richmond' }

    before do
      Listing.create(suburb: far_away_suburb, address: 'Bacon', lon: 150.1901922, lat: -33.5959814)
      Listing.create(suburb: neighbouring_suburb, address: 'Eggs', lon: 144.1499386, lat: -38.3750568)
      Listing.create(suburb: suburb, address: 'Spam', lon: 144.3034123, lat: -38.3512542)
    end

    it 'finds all the listings for the given suburb and surroundings' do
      expect(find_by_suburb.count).to eq(2)
    end

    it 'returns Torquay listing first' do
      expect(find_by_suburb.first.suburb).to eq(suburb)
    end

    context 'when there are no listings for the required suburb' do
      let(:suburb) { 'Woolloomooloo' }

      it 'returns an empty array' do
				expect(find_by_suburb).to be_empty
      end
    end
  end
end
