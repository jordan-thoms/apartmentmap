class RefreshOldListingsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Listing.where(invalid_at: nil).where(expired_at: nil).where('updated_at < ?', 3.days.ago).find_each do |listing|
      ScrapeTrademeListingPageJob.set(wait_until: rand(50).minutes.from_now).perform_later listing.page_url
    end
  end
end
