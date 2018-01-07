class AddPageUrlToListing < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :page_url, :string
  end
end
