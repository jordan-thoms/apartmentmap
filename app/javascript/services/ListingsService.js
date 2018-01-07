import axios from 'axios'
import _ from 'lodash'

export default class ListingsService {
  state = {
    bounds: null,
  }

  constructor(apartment_map) {
    this.apartment_map = apartment_map;
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
      this.apartment_map.updateListings(response.data)
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
