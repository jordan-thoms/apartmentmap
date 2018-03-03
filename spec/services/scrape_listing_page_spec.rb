require 'spec_helper'
require_relative '../../app/services/scrape_listing_page.rb'

describe ScrapeListingPage do
  context "#fetch_page", :vcr do
    it "fetches the page" do
      s = ScrapeListingPage.new("https://www.trademe.co.nz/property/residential-property-to-rent/auction-1496623440.htm?rsqid=8727997febb5444aa34b84b78e0aaff2")
      expect(s.page.title).to eq("City Centre, 1 bedroom, $460 pw | Trade Me Property")
    end
  end

  context "with listing 1496623440" do
    before do
      stub_request(:get, "https://www.trademe.co.nz/property/residential-property-to-rent/auction-1496623440.htm").to_return(File.new('spec/fixtures/auction-1496623440.curl'))
    end

    let(:scrape) { ScrapeListingPage.new("https://www.trademe.co.nz/property/residential-property-to-rent/auction-1496623440.htm") }

    context "#listing_id" do
      it "returns the id" do
        expect(scrape.listing_id).to eq("1496623440")
      end
    end

    context "#listing_title" do
      it "returns the title" do
        expect(scrape.listing_title).to eq("City Centre, 1 bedroom")
      end
    end

    context "#listing_price" do
      it "returns the price" do
        expect(scrape.listing_price).to eq("$460 per week")
      end
    end

    context "#parsed_price" do
      it "returns the price" do
        expect(scrape.parsed_price).to eq(460)
      end
    end

    context "#raw_location" do
      it "returns the raw_location" do
        expect(scrape.raw_location).to eq("23i/16 Gore Street\nCity Centre\nAuckland City\nAuckland\n")
      end
    end

    context "#latitude" do
      it "retuns the latitude" do
        expect(scrape.latitude).to eq(-36.846026)
      end
    end

    context "#longitude" do
      it "returns the longitude" do
        expect(scrape.longitude).to eq(174.7683292)
      end
    end

    context "#full_description" do
      it "returns the description" do
        expect(scrape.full_description).to start_with('1 bedroom apartment with 1 bathroom.')
      end
    end

    context "#image_urls" do
      it "returns the image urls" do
        expect(scrape.image_urls).to match_array([
        "https://trademe.tmcdn.co.nz/photoserver/plus/696813125.jpg",
        "https://trademe.tmcdn.co.nz/photoserver/plus/696812442.jpg",
        "https://trademe.tmcdn.co.nz/photoserver/plus/696812293.jpg",
        "https://trademe.tmcdn.co.nz/photoserver/plus/696812187.jpg",
        "https://trademe.tmcdn.co.nz/photoserver/plus/696812207.jpg",
        "https://trademe.tmcdn.co.nz/photoserver/plus/696812224.jpg",
        "https://trademe.tmcdn.co.nz/photoserver/plus/696812247.jpg",
        "https://trademe.tmcdn.co.nz/photoserver/plus/696812262.jpg",
        "https://trademe.tmcdn.co.nz/photoserver/plus/696812314.jpg",
        "https://trademe.tmcdn.co.nz/photoserver/plus/696812335.jpg",
        "https://trademe.tmcdn.co.nz/photoserver/plus/696812362.jpg",
        "https://trademe.tmcdn.co.nz/photoserver/plus/696812384.jpg",
        "https://trademe.tmcdn.co.nz/photoserver/plus/696812406.jpg",
        "https://trademe.tmcdn.co.nz/photoserver/plus/696812421.jpg",
        "https://trademe.tmcdn.co.nz/photoserver/plus/696813086.jpg",
        "https://trademe.tmcdn.co.nz/photoserver/plus/696814477.jpg",
        "https://trademe.tmcdn.co.nz/photoserver/plus/696814498.jpg",
        "https://trademe.tmcdn.co.nz/photoserver/plus/696814596.jpg"])
      end
    end

    context "#page_url" do
      it "gives the page url" do
        expect(scrape.page_url).to eq('https://www.trademe.co.nz/property/residential-property-to-rent/auction-1496623440.htm')
      end
    end

    context "#listing_type" do 
      it "gives the listing type" do
        expect(scrape.listing_type).to eq('apartment')
      end
    end

    context "#bedrooms" do
      it "gives the bedroom count" do
        expect(scrape.bedrooms).to eq(1)
      end
    end

    context "#bathrooms" do
      it "gives the bathroom count" do
        expect(scrape.bathrooms).to eq(1)
      end
    end
  end

  context "with listing 1511258703" do
    before do
      stub_request(:get, "https://www.trademe.co.nz/property/residential-property-to-rent/auction-1511258703.htm").to_return(File.new('spec/fixtures/auction-1511258703.curl'))
    end

    let(:scrape) { ScrapeListingPage.new("https://www.trademe.co.nz/property/residential-property-to-rent/auction-1511258703.htm") }

    context "#listing_id" do
      it "returns the id" do
        expect(scrape.listing_id).to eq("1511258703")
      end
    end

    context "#listing_title" do
      it "returns the title" do
        expect(scrape.listing_title).to eq("Mount Cook, 5 bedrooms")
      end
    end

    context "#listing_price" do
      it "returns the price" do
        expect(scrape.listing_price).to eq("$1,250 per week")
      end
    end

    context "#parsed_price" do
      it "returns the price" do
        expect(scrape.parsed_price).to eq(1250)
      end
    end

    context "#raw_location" do
      it "returns the raw_location" do
        expect(scrape.raw_location).to eq("34 wright street\nMount Cook\nWellington\nWellington\n")
      end
    end

    context "#latitude" do
      it "retuns the latitude" do
        expect(scrape.latitude).to eq(-41.305232)
      end
    end

    context "#longitude" do
      it "returns the longitude" do
        expect(scrape.longitude).to eq(174.7735474)
      end
    end

    context "#full_description" do
      it "returns the description" do
        expect(scrape.full_description).to start_with("5 bedroom house with 2 bathrooms.\n\n5  very very  large bedrooms")
      end
    end

    context "#image_urls" do
      it "returns the image urls" do
        expect(scrape.image_urls).to match_array([
          "https://trademe.tmcdn.co.nz/photoserver/plus/706361469.jpg", 
          "https://trademe.tmcdn.co.nz/photoserver/plus/706361845.jpg", 
          "https://trademe.tmcdn.co.nz/photoserver/plus/706362129.jpg", 
          "https://trademe.tmcdn.co.nz/photoserver/plus/706362277.jpg", 
          "https://trademe.tmcdn.co.nz/photoserver/plus/706362403.jpg", 
          "https://trademe.tmcdn.co.nz/photoserver/plus/706362504.jpg", 
          "https://trademe.tmcdn.co.nz/photoserver/plus/707005046.jpg", 
          "https://trademe.tmcdn.co.nz/photoserver/plus/707005165.jpg", 
          "https://trademe.tmcdn.co.nz/photoserver/plus/707005377.jpg"
        ])
      end
    end

    context "#page_url" do
      it "gives the page url" do
        expect(scrape.page_url).to eq('https://www.trademe.co.nz/property/residential-property-to-rent/auction-1511258703.htm')
      end
    end

    context "#is_expired?" do
      it "returns false" do
        expect(scrape.is_expired?).to eq(false)
      end
    end

    context "#listing_type" do 
      it "gives the listing type" do
        expect(scrape.listing_type).to eq('house')
      end
    end

    context "#bedrooms" do
      it "gives the bedroom count" do
        expect(scrape.bedrooms).to eq(5)
      end
    end

    context "#bathrooms" do
      it "gives the bathroom count" do
        expect(scrape.bathrooms).to eq(2)
      end
    end
  end

  context "with listing 1512467175" do
    before do
      stub_request(:get, "https://www.trademe.co.nz/property/residential-property-to-rent/auction-1512467175.htm").to_return(File.new('spec/fixtures/auction-1512467175.curl'))
    end

    let(:scrape) { ScrapeListingPage.new("https://www.trademe.co.nz/property/residential-property-to-rent/auction-1512467175.htm") }

    context "#bedrooms" do
      it "gives the bedroom count" do
        expect(scrape.bedrooms).to eq(6)
      end
    end

    context "#bathrooms" do
      it "gives the bathroom count" do
        expect(scrape.bathrooms).to eq(2)
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
