class ListingSerializer
  include FastJsonapi::ObjectSerializer
  set_type :listing  # optional
  attributes :id, :source, :source_listing_id, :title, :raw_price, :raw_location, :full_description, :listing_attributes, :latitude, :longitude, :page_url, :image_urls
end

# == Schema Information
#
# Table name: listings
#
#  id                 :integer          not null, primary key
#  source             :integer          not null
#  source_listing_id  :text             not null
#  title              :text
#  raw_price          :text
#  raw_location       :text
#  full_description   :text
#  listing_attributes :jsonb
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  latitude           :float
#  longitude          :float
#  page_url           :string
#  listing_type       :integer
#  bedrooms           :integer
#  bathrooms          :integer
#  parsed_price       :integer
#  cached_image_urls  :string           is an Array
#  expires_at         :datetime
#  invalid_at         :datetime
#
# Indexes
#
#  index_listings_on_source_and_source_listing_id  (source,source_listing_id) UNIQUE
#
