import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import { withStyles } from 'material-ui/styles';
import { Carousel } from 'react-responsive-carousel';
import 'react-responsive-carousel/lib/styles/carousel.css'

const styles = theme => ({
  carousel: {
  }
});

class ListingCarousel extends React.Component {
    render() {
        const { classes, theme } = this.props;

        return (
            <Carousel showArrows={true} className={classes.carousel} showThumbs={false}>
                {
                  this.props.image_urls.map((image_url) =>
                    <div key={image_url}>
                        <img src={image_url} />
                    </div>
                  )
                }
            </Carousel>
        );
    }
}

export default withStyles(styles, { withTheme: true })(ListingCarousel)
//  onChange={onChange} onClickItem={onClickItem} onClickThumb={onClickThumb}
