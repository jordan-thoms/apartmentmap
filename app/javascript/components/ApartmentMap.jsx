import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import Button from 'material-ui/Button'
import { GoogleMap, Marker, withGoogleMap, withScriptjs } from "react-google-maps"
import { compose, withProps , defaultProps, withHandlers } from "recompose"
import ListingPanel from './ListingPanel'
import ListingsService from '../services/ListingsService'
import FilterPanel from './FilterPanel'
import update from 'immutability-helper'

class CustomMarker extends React.Component {
  handleClick = () => {
    this.props.onClick(this.props.value);
  }

  render() {
    return (
      <Marker position={{ lat: this.props.position.lat, lng: this.props.position.lng }} onClick={this.handleClick} />
    );
  }

}  

const MapInternal = compose(
    withProps({
      googleMapURL: "https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=geometry,drawing,places&use_slippy=true&key=AIzaSyDuigDIg_r4H8vUku7sT4FASBdRQfoMYa4",
      loadingElement: <div style={{ height: `100%` }} />,
      containerElement: <div style={{ height: `100%` }} />,
      mapElement: <div style={{ height: `100%` }} />,
    }),
    defaultProps({
      listings: []
    }),
    withScriptjs,
    withGoogleMap,
    withHandlers(() => {
      const refs = {
        map: undefined,
      }

      return {
        onMapMounted: () => ref => {
          refs.map = ref
        },
        onBoundsChanged: props => () => {
          try {
            props.onBoundsChanged(refs.map.getBounds())
          } catch (e) {
            console.error(e);
          }
        }
      }
    }),
  )((props) =>
    <GoogleMap
      ref={props.onMapMounted}
      defaultZoom={11}
      defaultCenter={{ lat: -36.8573214, lng: 174.7617209 }}
      onBoundsChanged={props.onBoundsChanged}
      options={{fullscreenControl: false}}
    >
      {Object.values(props.listings).map((listing) =>
        <CustomMarker value={listing.id} key={listing.id} position={{ lat: listing.latitude, lng: listing.longitude }} onClick={props.onMarkerClick} />
        )
      }
    </GoogleMap>
)

class ApartmentMap extends React.Component {
  state = {
    listings: [],
    selectedListing: null,
    filters: {
      bedrooms: {min: 1, max: 6},
      bathrooms: {min: 1, max: 6},
      parsed_price: {min: 1, max: 1500}
    }
  }

  componentDidMount() {
  }


  handleMarkerClick = (listingId) => {
    this.setState({selectedListing: this.state.listings[listingId]})
  }

  handleFilterChange = (new_filters, options) => {
    this.setState(update(this.state, {
      filters: {$merge: new_filters}
    }))
    if (!options || options['update'] != false) {
      this.listingsService.filterUpdated()
    }
  }

  handleListingClose = () => {
    this.setState({selectedListing: null})
  }

  onBoundsChanged = (bounds) => {
    this.listingsService.updateBounds(bounds)
  }

  updateListings = (listings) => {
    this.setState({listings: listings})
  }

  listingsService = new ListingsService(this)

  render() {
    return (
      <div style={{height: "100%"}}>
        <MapInternal
          listings={this.state.listings}
          onMarkerClick={this.handleMarkerClick}
          onBoundsChanged={this.onBoundsChanged}
        />
        <ListingPanel
          listing={this.state.selectedListing}
          onClose={this.handleListingClose}
        />
        <FilterPanel
          filters={this.state.filters}
          onFiltersChanged={this.handleFilterChange}
        />
      </div>
    )
  }
}

export default ApartmentMap
