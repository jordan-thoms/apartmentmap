require 'spec_helper'
require_relative '../../app/services/scrape_listing_page.rb'

describe ScrapeListingPage do
  context "#fetch_page", :vcr do
    it "fetches the page" do
      s = ScrapeListingPage.new("https://www.trademe.co.nz/property/residential-property-to-rent/auction-1560360108.htm?rsqid=8727997febb5444aa34b84b78e0aaff2")
      expect(s.page.title).to eq("Green Bay, 2 bedrooms, $560 pw | Trade Me Property")
    end
  end

  context "with listing 1560360108" do
    before do
      stub_request(:get, "https://www.trademe.co.nz/property/residential-property-to-rent/auction-1560360108.htm").to_return(File.new('spec/fixtures/auction-1560360108.curl'))
    end

    let(:scrape) { ScrapeListingPage.new("https://www.trademe.co.nz/property/residential-property-to-rent/auction-1560360108.htm") }

    context "#listing_id" do
      it "returns the id" do
        expect(scrape.listing_id).to eq("1560360108")
      end
    end

    context "#listing_title" do
      it "returns the title" do
        expect(scrape.listing_title).to eq("Green Bay, 2 bedrooms")
      end
    end

    context "#listing_price" do
      it "returns the price" do
        expect(scrape.listing_price).to eq("$560 per week")
      end
    end

    context "#parsed_price" do
      it "returns the price" do
        expect(scrape.parsed_price).to eq(560)
      end
    end

    context "#raw_location" do
      it "returns the raw_location" do
        expect(scrape.raw_location).to eq("63 Godley Road, Green Bay, Waitakere City, Auckland")
      end
    end

    context "#latitude" do
      it "retuns the latitude" do
        expect(scrape.latitude).to eq(-36.9308112)
      end
    end

    context "#longitude" do
      it "returns the longitude" do
        expect(scrape.longitude).to eq(174.6785934)
      end
    end

    context "#full_description" do
      it "returns the description" do
        expect(scrape.full_description).to start_with('2 bedroom house with 1 bathroom.')
      end
    end

    context "#image_urls" do
      it "returns the image urls" do
        expect(scrape.image_urls).to match_array([
         "https://trademe.tmcdn.co.nz/photoserver/plus/740168017.jpg",
         "https://trademe.tmcdn.co.nz/photoserver/plus/740168019.jpg",
         "https://trademe.tmcdn.co.nz/photoserver/plus/740168025.jpg",
         "https://trademe.tmcdn.co.nz/photoserver/plus/740168031.jpg",
         "https://trademe.tmcdn.co.nz/photoserver/plus/740168037.jpg",
         "https://trademe.tmcdn.co.nz/photoserver/plus/740168043.jpg",
         "https://trademe.tmcdn.co.nz/photoserver/plus/740168047.jpg",
         "https://trademe.tmcdn.co.nz/photoserver/plus/740168050.jpg",
         "https://trademe.tmcdn.co.nz/photoserver/plus/740168053.jpg",
         "https://trademe.tmcdn.co.nz/photoserver/plus/740168057.jpg",
         "https://trademe.tmcdn.co.nz/photoserver/plus/740168067.jpg",
         "https://trademe.tmcdn.co.nz/photoserver/plus/740168072.jpg",
         "https://trademe.tmcdn.co.nz/photoserver/plus/740168076.jpg",
         "https://trademe.tmcdn.co.nz/photoserver/plus/740168082.jpg",
         "https://trademe.tmcdn.co.nz/photoserver/plus/740168086.jpg",
         "https://trademe.tmcdn.co.nz/photoserver/plus/740168093.jpg"])
      end
    end

    context "#page_url" do
      it "gives the page url" do
        expect(scrape.page_url).to eq('https://www.trademe.co.nz/property/residential-property-to-rent/auction-1560360108.htm')
      end
    end

    context "#listing_type" do 
      it "gives the listing type" do
        expect(scrape.listing_type).to eq('house')
      end
    end

    context "#bedrooms" do
      it "gives the bedroom count" do
        expect(scrape.bedrooms).to eq(2)
      end
    end

    context "#bathrooms" do
      it "gives the bathroom count" do
        expect(scrape.bathrooms).to eq(1)
      end
    end
  end


  context "with listing 1499068052" do
    before do
      stub_request(:get, "https://www.trademe.co.nz//property/residential-property-to-rent/auction-1499068052.htm").to_return(File.new('spec/fixtures/auction-1499068052.curl'))
    end

    let(:scrape) { ScrapeListingPage.new("https://www.trademe.co.nz//property/residential-property-to-rent/auction-1499068052.htm") }

    context "#is_valid_listing" do
      it "returns false" do
        expect(scrape.is_valid_listing?).to eq(false)
      end
    end

    context "#is_expired?" do
      it "returns false" do
        expect(scrape.is_expired?).to eq(false)
      end
    end

    context "#parsed_price" do
      it "returns nil" do
        expect(scrape.parsed_price).to eq(nil)
      end
    end
  end

  context "with listing 1503511898" do
    before do
      stub_request(:get, "https://www.trademe.co.nz//property/residential-property-to-rent/auction-1503511898.htm").to_return(File.new('spec/fixtures/auction-1503511898.curl'))
    end

    let(:scrape) { ScrapeListingPage.new("https://www.trademe.co.nz//property/residential-property-to-rent/auction-1503511898.htm") }

    context "#is_valid_listing?" do
      it "returns true" do
        expect(scrape.is_valid_listing?).to eq(true)
      end
    end

    context "#is_expired?" do
      it "returns true" do
        expect(scrape.is_expired?).to eq(true)
      end
    end

    context "#parsed_price" do
      it "returns nil" do
        expect(scrape.parsed_price).to eq(nil)
      end
    end

    context "#listing_id" do
      it "returns the id" do
        expect(scrape.listing_id).to eq("1503511898")
      end
    end
  end

end
