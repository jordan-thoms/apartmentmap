import axios from 'axios'
import _ from 'lodash'
import update from 'immutability-helper'

export default class ListingsService {
  state = {
    bounds: null,
  }

  constructor(apartment_map) {
    this.apartment_map = apartment_map;
  }

  setListingState = (listingId, new_state) => {
    var updateMap = {}
    updateMap[listingId] = {$merge: new_state}
    var newListings = update(this.apartment_map.state.listings, updateMap)
    this.apartment_map.updateListings(newListings)

    localStorage.setItem("listing."+listingId, JSON.stringify(newListings[listingId]))
  }

  filterUpdated = () => {
    if (this.cancel_func) {
      this.cancel_func()
      this.cancel_func = null
    }
    return this.runQuery()
  }

  updateBounds = (bounds) => {
    this.state.bounds = bounds
    this.throttledQuery()
  }

  runQuery = () => {
    axios.get('/listings', {
      params: {
        json_params: {
          bounds: this.state.bounds,
          filters: this.apartment_map.state.filters
        }
      },
      cancelToken: new axios.CancelToken((c) => {
        this.cancel_func = c;
      })
    }).then((response) => {
      var listings = {}
      response.data.map((listing) => {
        var localData = localStorage.getItem("listing." + listing.id)

        if(localData) {
          try {
            var data = JSON.parse(localData)
            if (data.hidden) {
              listing.hidden = true
            } else {
              listing.hidden = false
            }

            if (data.visited) {
              listing.visited = true
            } else {
              listing.visited = false
            }

            if (data.favourite) {
              listing.favourite = true
            } else {
              listing.favourite = false
            }

          } catch(err) { console.error(err) }
        }

        listings[listing.id] = listing
      })

      this.apartment_map.updateListings(listings)
    }, (error) => {
      if (axios.isCancel(error)) {
        console.log('Request canceled', error.message);
      } else {
        console.error(error);
      }
    })
  }

  throttledQuery = _.throttle(this.runQuery, 2000)

}
