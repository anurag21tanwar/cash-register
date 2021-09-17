import React from "react";
import Loader from './Loader';
import Items from './Items';
import PropTypes from "prop-types";

export default class Basket extends React.Component {
  render() {
    const {items, loading, deleteFromBasket, updateItemQuantity} = this.props;

    return (
      <div className="py-5">
        <div className="text-right mb-3"/>
        <h4 className="card-title">Basket</h4>
        <div className="row">
          {
            loading ? <Loader/> :
              <div>
                {items.length > 0 ?
                  <Items
                    items={items}
                    deleteFromBasket={deleteFromBasket}
                    updateItemQuantity={updateItemQuantity}
                  />
                  : (
                    <div
                      className="d-flex align-items-center justify-content-center">
                      <h6>Nothing added in basket yet!</h6>
                    </div>
                  )
                }
              </div>
          }
        </div>
      </div>
    )
  }
}

Basket.propTypes = {
  items: PropTypes.array.isRequired,
  loading: PropTypes.bool.isRequired,
  deleteFromBasket: PropTypes.func.isRequired,
  updateItemQuantity: PropTypes.func.isRequired
};