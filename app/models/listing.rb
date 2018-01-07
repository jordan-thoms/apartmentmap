class Listing < ApplicationRecord
  enum source: { :trademe =>  0 }
  enum listing_type: { :apartment => 0,  :"car park"=> 1, :house => 2, :townhouse => 3, :unit => 4 }
  has_many_attached :images

  def image_urls
    unless self.cached_image_urls
      self.cached_image_urls = self.images.map {|image| Rails.application.routes.url_helpers.url_for(image) }
      save!
    end

    self.cached_image_urls
  end

  def self.from_trademe_scraper(scraper)
    listing = Listing.find_or_initialize_by(source: :trademe, source_listing_id: scraper.listing_id)
    listing.title = scraper.listing_title
    listing.raw_price = scraper.listing_price
    listing.parsed_price = scraper.parsed_price
    listing.raw_location = scraper.raw_location
    listing.full_description = scraper.full_description
    listing.listing_attributes = scraper.attributes
    listing.latitude = scraper.latitude
    listing.longitude = scraper.longitude
    listing.page_url = scraper.page_url
    listing.bedrooms = scraper.bedrooms
    listing.bathrooms = scraper.bathrooms
    listing.listing_type = scraper.listing_type
    listing.save!

    # Download and attach images
    unless listing.images.attached?
      scraper.image_urls.each do |img_url|
        file_uri = URI.parse(img_url)
        file_uri.open do |file|
          listing.images.attach(io: file, filename: File.basename(file_uri.path), content_type: 'image/jpg')
        end
      end
    end
    listing.update_attribute(:cached_image_urls, nil)
    listing
  end
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
#  listing_type       :integer          not null
#  bedrooms           :integer          not null
#  bathrooms          :integer          not null
#  parsed_price       :decimal(, )      not null
#  cached_image_urls  :string           is an Array
#
# Indexes
#
#  index_listings_on_source_and_source_listing_id  (source,source_listing_id) UNIQUE
#
