class MakeListingFieldsOptional < ActiveRecord::Migration[5.2]
  def change
    change_table :listings do |t|
      t.change :listing_type, :integer, null: true
      t.change :bedrooms, :integer, null: true
      t.change :bathrooms, :integer, null: true
      t.change :parsed_price, :integer, null: true
    end
  end
end
