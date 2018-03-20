class CreatePropertiesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.string :address, null: false
      t.string :suburb, null: false
      t.datetime :created_at, :datetime
      t.datetime :updated_at, :datetime
    end
  end
end
