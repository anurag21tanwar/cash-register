import React from "react";
import { Link } from "react-router-dom";
import PropTypes from "prop-types";
import Basket from "./Basket";

export default class Items extends React.Component {
  totalAmount(items) {
    return items.reduce((sum, item) => sum + parseFloat(item.amount), 0).toFixed(2);
  }

  decreaseQuantity(itemId) {
    const url = `/api/v1/items/${itemId}/sub`;
    const token = document.querySelector("meta[name='csrf-token']").content;

    fetch(url, {
      method: "PUT",
      headers: {
        "X-CSRF-Token": token,
        "Content-Type": "application/json"
      }
    }).then(response => {
      if (response.ok) {
        return response.json();
      }
    }).then(response => {
      this.props.updateItemQuantity(response);
    });
  }

  increaseQuantity(itemId) {
    const url = `/api/v1/items/${itemId}/add`;
    const token = document.querySelector("meta[name='csrf-token']").content;

    fetch(url, {
      method: "PUT",
      headers: {
        "X-CSRF-Token": token,
        "Content-Type": "application/json"
      }
    }).then(response => {
      if (response.ok) {
        return response.json();
      }
    }).then(response => {
      this.props.updateItemQuantity(response);
    });
  }

  removeFromBasket(itemId) {
    const url = `/api/v1/items/${itemId}`;
    const token = document.querySelector("meta[name='csrf-token']").content;

    fetch(url, {
      method: "DELETE",
      headers: {
        "X-CSRF-Token": token,
        "Content-Type": "application/json"
      }
    })
      .then(response => {
        if (response.ok) {
          return response.json();
        }
      }).then(response => {
      this.props.deleteFromBasket(response);
    });
  }

  render() {
    const { items } = this.props;
    return (
      items.length > 0 ?
        <table className="table table-striped">
          <thead>
          <tr>
            <th>Code</th>
            <th>Quantity</th>
            <th>Amount</th>
            <th/>
          </tr>
          </thead>
          <tbody>
          {items.map((item, index) => (
            <tr key={index}>
              <td>{item.code}</td>
              <td>
                <span>
                  <Link to="#"
                        onClick={() => this.decreaseQuantity(item.id)}
                        className="btn"><i className="bi bi-caret-left-fill"></i>
                  </Link>
                </span>{item.quantity}
                <span>
                  <Link to="#"
                        onClick={() => this.increaseQuantity(item.id)}
                        className="btn"><i className="bi bi-caret-right-fill"></i>
                  </Link>
                </span>
              </td>
              <td>{`€${item.amount}`}</td>
              <td><Link to="#" onClick={() => this.removeFromBasket(item.id)} className="btn">
                <i className="bi bi-trash"></i>
              </Link></td>
            </tr>))
          }
          <tr>
            <td>Total Amount</td>
            <td/>
            <td>{`€${this.totalAmount(items)}`}</td>
            <td/>
          </tr>
          </tbody>
        </table> : null
    )
  }
}

Items.propTypes = {
  items: PropTypes.array.isRequired,
  deleteFromBasket: PropTypes.func.isRequired,
  updateItemQuantity: PropTypes.func.isRequired
};