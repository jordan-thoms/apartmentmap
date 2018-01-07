class AddPriceToListing < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :parsed_price, :decimal, null: false
  end
end
