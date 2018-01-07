import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import { withStyles } from 'material-ui/styles';

import Typography from 'material-ui/Typography';
import Paper from 'material-ui/Paper';
import InputRange from 'react-input-range';
import 'react-input-range/lib/css/index.css';
const styles = theme => ({
  root: theme.mixins.gutters({
    position: 'absolute',
    right: '50px',
    top: '0px',
    width: '200px',
    paddingTop: 16,
    paddingBottom: 16,
    marginTop: theme.spacing.unit * 3,
  }),
  inputRange: {
    paddingTop: '20px',
    paddingBottom: '20px',
    paddingLeft: '5px',
    paddingRight: '5px',

  }
});

class FilterPanel extends React.Component {
  render() {
    const { classes, theme } = this.props;

    return <div>
      <Paper className={classes.root} elevation={4}>
        Bedrooms:
        <div className={classes.inputRange}>
          <InputRange
            maxValue={6}
            minValue={1}
            value={this.props.filters.bedrooms}
            allowSameValues={true}
            onChange={value => this.props.onFiltersChanged({ bedrooms: value })} />
        </div>
        Bathrooms:
        <div className={classes.inputRange}>
          <InputRange
            maxValue={6}
            minValue={1}
            value={this.props.filters.bathrooms}
            allowSameValues={true}
            onChange={value => this.props.onFiltersChanged({ bathrooms: value })} />
        </div>

        Price:
        <div className={classes.inputRange}>
          <InputRange
            maxValue={1500}
            minValue={1}
            value={this.props.filters.parsed_price}
            allowSameValues={true}
            onChange={value => this.props.onFiltersChanged({ parsed_price: value }, {update: false})}
            onChangeComplete={value => this.props.onFiltersChanged({ parsed_price: value })} />
        </div>
      </Paper>
    </div>;
  }

}
FilterPanel.propTypes = {
  classes: PropTypes.object.isRequired,
  theme: PropTypes.object.isRequired,
};


export default withStyles(styles, { withTheme: true })(FilterPanel)
