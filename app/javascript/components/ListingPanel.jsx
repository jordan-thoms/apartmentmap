import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import { withStyles } from 'material-ui/styles';
import CloseIcon from 'material-ui-icons/Close';
import OpenInBrowserIcon from 'material-ui-icons/OpenInBrowser';
import StarIcon from 'material-ui-icons/Star';

import IconButton from 'material-ui/IconButton';
import Divider from 'material-ui/Divider';
import Drawer from 'material-ui/Drawer';
import Typography from 'material-ui/Typography';
import ListingCarousel from './ListingCarousel'

const styles = theme => ({
  drawerPaper: {
    position: 'absolute',
    height: '100%',
    width: '500px',
  },
  drawerContainer: {
    display: 'flex',
    flexDirection: 'column',
  },
  drawerHeader: {
    backgroundColor: 'white',
    zIndex:'10',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'flex-end',
    padding: '0 8px',
    ...theme.mixins.toolbar,
  },
  drawerContents: {
    overflow: 'auto'
  },
  fullDescription: {
    whiteSpace: 'pre-wrap'
  }
});

class ListingPanel extends React.Component {
  openInBrowser = () => {
    window.open(this.props.listing.page_url, "_blank")
  }

  render() {
    const { classes, theme } = this.props;

    return <Drawer
      type="persistent"
      anchor="left"
      open={!!this.props.listing}
      classes={{paper: classes.drawerPaper}}
    >
      {this.props.listing &&
        <div className={classes.drawerContainer}>
          <div className={classes.drawerHeader}>
            <Typography type="title" gutterBottom>
              {this.props.listing.title}, {this.props.listing.raw_price}
            </Typography>
            <IconButton onClick={this.props.onFavourite}>
              <StarIcon />
            </IconButton>
            <IconButton onClick={this.openInBrowser}>
              <OpenInBrowserIcon />
            </IconButton>
            <IconButton onClick={this.props.onClose}>
              <CloseIcon />
            </IconButton>
          </div>

          <div className={classes.drawerContents}>
            <Divider />
            <ListingCarousel image_urls={this.props.listing.image_urls} />
            <Divider />
            {Object.entries(this.props.listing.listing_attributes).map((arr) =>
              <div key={arr[0]}><b>{arr[0]}</b>: {arr[1]}</div>
            )}

            <div className={classes.fullDescription}>
              {this.props.listing.full_description}
            </div>
          </div>
        </div>
      }
    </Drawer>
  }

}
ListingPanel.propTypes = {
  classes: PropTypes.object.isRequired,
  theme: PropTypes.object.isRequired,
};


export default withStyles(styles, { withTheme: true })(ListingPanel)
