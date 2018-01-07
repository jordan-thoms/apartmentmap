class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.integer :source, null: false
      t.text :source_listing_id, null: false
      t.text :title
      t.text :raw_price
      t.text :raw_location
      t.text :full_description
      t.jsonb :listing_attributes
      t.timestamps

      t.index [:source, :source_listing_id], unique: true
    end
  end
end
