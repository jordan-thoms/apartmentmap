class AddExtraFieldsToListing < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :listing_type, :integer, null: false
    add_column :listings, :bedrooms, :integer, null: false
    add_column :listings, :bathrooms, :integer, null: false
  end
end
