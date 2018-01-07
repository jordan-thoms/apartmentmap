class AddCachedImageUrlsToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :cached_image_urls, :string, array: true
  end
end
