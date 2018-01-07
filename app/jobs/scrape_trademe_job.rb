class ScrapeTrademeJob < ApplicationJob
  queue_as :default

  def perform(page_limit)
    agent = Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari'
    }
    page = agent.get("https://www.trademe.co.nz/property")
    form = page.forms_with(action: "/property").first

    form.field_with!(name: 'SearchTabs$ctl00$PropertySearchRentOrForSale').value ="rent"

    page = agent.submit(form, form.buttons.first)

    while page do
      page.search('.property-card-title').search('a').each do |node|
        href= node.attributes['href'].value
        id = href.match(/auction-([0-9]+)/)[1]
        puts id
        unless Listing.where(source: :trademe, source_listing_id: id).count > 0
          full_href="https://www.trademe.co.nz/" + node.attributes['href']
          ScrapeTrademeListingPageJob.perform_later full_href
          puts "Scraping #{id}"
        end
      end

      page = page.link_with(text: 'Next >>').click
      page_limit -= 1

      break if page_limit < 0
    end

  end
end
