class ScrapeTrademeListingPageJob < ApplicationJob
  queue_as :default

  def perform(page_url)
    scraper = ScrapeListingPage.new(page_url)
    Listing.from_trademe_scraper(scraper)
  end
end
