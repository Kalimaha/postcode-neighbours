class AddMoreFieldsToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :bedrooms, :integer
    add_column :listings, :bathrooms, :integer
    add_column :listings, :carports, :integer
    add_column :listings, :description, :string
    add_column :listings, :rent, :float
  end
end
