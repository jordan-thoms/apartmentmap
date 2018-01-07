require 'mechanize'
class ScrapeListingPage
  attr_reader :page_url
  
  def initialize(page_url)
    @page_url = page_url
  end

  def page
    @page ||= fetch_page
  end

  def listing_title
    page.search('#ListingTitle_title').text.strip
  end

  def listing_price
    page.search('#ListingTitle_classifiedTitlePrice').text.strip
  end

  def parsed_price
    page.search('#ListingTitle_classifiedTitlePrice').text.strip.match(/\$([\d,]+) per/)[1].gsub(',','').to_f
  end

  def listing_id
    page.search('#ListingTitle_noStatusListingNumberContainer').text.strip.scan(/[0-9]+/).first
  end

  def raw_location
    attributes['Location']
  end


  def latitude
    map_state.match(/lat: ([-0-9,\.]+),/)[1].to_f
  end

  def longitude
    map_state.match(/lng: ([-0-9,\.]+),/)[1].to_f
  end

  def full_description
    @description ||= page.search('#ListingDescription_ListingDescription').inner_html.strip.gsub('<br>', "\n")
  end

  def listing_type
    matched_description['type']
  end

  def bedrooms
    matched_description['bedrooms'].to_i
  end

  def bathrooms
    matched_description['bathrooms'].to_i
  end
  
  def attributes
    @attributes ||= begin
      attributes = {}
      page.search('#ListingAttributes').search('tr').each do |node|
        attribute_name = node.search('th').text.strip.gsub(':','')
        attribute_value = node.search('td').inner_html.strip.gsub('<br>', "\n")
        attributes[attribute_name] = attribute_value
      end
      attributes
    end
  end
  
  def image_urls
    page.search('#listingPhotos').search('img').map do |node|
      node.attributes['src'].value.gsub('thumb', 'plus').gsub('tq', 'plus')
    end.select{|s| s.start_with? 'https://trademe.tmcdn.co.nz/photoserver'}.uniq
  end

  private
  def m_agent
    @agent ||= Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari'
    }
  end

  def fetch_page
    m_agent.get(@page_url)
  end

  def map_state
    map_state ||= page.search('script').map(&:text).select{|text| text.include? 'mapState'}.first
  end


  def matched_description
    @matches ||= full_description.match(/(?<bedrooms>[\d]+)(?: or more)? bedroom (?<type>[\w\s]+) with (?<bathrooms>[\d]+)(?: or more)? bathroom/)
  end
end
