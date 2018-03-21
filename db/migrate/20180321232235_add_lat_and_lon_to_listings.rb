class AddLatAndLonToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :lat, :float
    add_column :listings, :lon, :float
  end
end
