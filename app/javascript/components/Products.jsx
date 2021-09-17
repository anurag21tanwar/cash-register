import React from "react";
import { Link } from "react-router-dom";
import Loader from "./Loader";
import PropTypes from "prop-types";

export default class Products extends React.Component {
  constructor(props) {
    super(props)
    this.handleAddToBasket = this.handleAddToBasket.bind(this);
  }

  handleAddToBasket(productId) {
    const url = "/api/v1/items";
    const token = document.querySelector("meta[name='csrf-token']").content;
    const body = {product_id: productId};

    fetch(url, {
      method: "POST",
      headers: {
        "X-CSRF-Token": token,
        "Content-Type": "application/json"
      },
      body: JSON.stringify(body)
    })
      .then(response => {
        if (response.ok) {
          return response.json();
        }
      })
      .then(response => {
        this.props.addToBasket(response);
      });
  }

  render() {
    const { products, loading } = this.props;

    return (
      <div className="py-5">
        <div className="text-right mb-3"/>
        <h4 className="card-title">Products Registered</h4>
        <div className="row">
          {
            loading ? <Loader/> :
              products.length > 0 ?
                products.map((product, index) => (
                  <div key={index} style={{width: '15rem'}}>
                    <div className="card">
                      <div className="card-body">
                        <h5 className="card-title">{`${product.name}, ${product.code}`}</h5>
                        <p className="card-text">{`€${product.price}`}</p>
                        <Link to="#" onClick={() => this.handleAddToBasket(product.id)}
                              className="btn btn-primary">
                          Add to Basket
                        </Link>
                      </div>
                    </div>
                    <br/>
                  </div>
                )) : (
                  <div
                    className="d-flex align-items-center justify-content-center">
                    <h6>No products registered yet!</h6>
                  </div>
                )
          }
        </div>
      </div>
    )
  }
}

Products.propTypes = {
  products: PropTypes.array.isRequired,
  loading: PropTypes.bool.isRequired,
  addToBasket: PropTypes.func.isRequired
};