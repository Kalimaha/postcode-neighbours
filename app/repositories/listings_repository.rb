class ListingsRepository
  class << self
    def find_by_suburb(suburb:)
      raw_result(suburb).map { |listing| Listing.new(listing) }
    end

    private

    def raw_result(suburb)
      ActiveRecord::Base.connection.execute(sql(suburb))
    end

    def sql(suburb)
      <<-SQL.squish
        SELECT *
        FROM listings l
        WHERE l.suburb IN (
          SELECT b.ssc_name
          FROM suburbs a
          JOIN suburbs b ON ST_INTERSECTS(a.wkb_geometry, b.wkb_geometry)
          WHERE a.ssc_name = '#{suburb}'
        )
        ORDER BY ST_Distance(#{centroid(suburb)}, ST_MakePoint(l.lon, l.lat)) ASC;
      SQL
    end

    def centroid(suburb)
      "ST_MakePoint((SELECT lon FROM suburbs WHERE ssc_name = '#{suburb}'), (SELECT lat FROM suburbs WHERE ssc_name = '#{suburb}'))"
    end
  end
end
