class ListingsController < ApplicationController
  FILTERABLE_ATTRIBUTES = ['bedrooms', 'bathrooms', 'parsed_price', 'listing_type']

  def index
    json_params = params[:json_params].present? ? JSON.parse(params[:json_params]) : nil

    unless json_params 
      head :no_content
      return
    end

    listing_query = Listing.all.where(invalid_at: nil).where(expired_at: nil)

    if json_params['bounds']
      # listing_query = listing_query.where('latitude BETWEEN ? AND ?', json_params['bounds']['south'], json_params['bounds']['north']).where('longitude BETWEEN ? AND ?', json_params['bounds']['west'], json_params['bounds']['east'])
      listing_query = listing_query.where(
        "ST_MakePoint(longitude, latitude) && ST_ShiftLongitude(ST_MakeEnvelope(?, ?, ?, ?))",
        json_params['bounds']['west'], json_params['bounds']['south'],json_params['bounds']['east'],  json_params['bounds']['north']
      )
    end

    filters = json_params['filters']
    FILTERABLE_ATTRIBUTES.each do |attribute_name|
      attribute_value = filters[attribute_name]
      if attribute_value
        if attribute_value['min'] && attribute_value['max']
          listing_query = listing_query.where("#{attribute_name} BETWEEN ? and ?", attribute_value['min'], attribute_value['max'])
          # attribute_name is safe, it has to be in the filterable_attributes list.
        else
          listing_query = listing_query.where(attribute_name => attribute_value)
        end
      end
    end

    render json: ListingSerializer.new(listing_query).serializable_hash
  end
end
