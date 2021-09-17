import React from "react";
import Products from "./Products";
import Basket from "./Basket";

export default class Home extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      products: [],
      productsLoading: true,
      items: [],
      itemsLoading: true
    }
    this.getProducts = this.getProducts.bind(this);
    this.getItems = this.getItems.bind(this);
    this.addToBasket = this.addToBasket.bind(this);
    this.deleteFromBasket = this.deleteFromBasket.bind(this);
    this.updateItemQuantity = this.updateItemQuantity.bind(this);
  }

  componentDidMount() {
    this.getProducts();
    this.getItems();
  }

  getProducts() {
    const url = "/api/v1/products";
    fetch(url)
      .then(response => {
        if (response.ok) {
          return response.json();
        }
      })
      .then(response => {
        this.setState({products: response, productsLoading: false});
      });
  }

  getItems() {
    const url = `/api/v1/basket/${currentBasketId}`
    fetch(url)
      .then(response => {
        if (response.ok) {
          return response.json();
        }
      })
      .then(response => {
        this.setState({items: response.items, itemsLoading: false});
      });
  }

  addToBasket(newItem) {
    let items = this.state.items;
    const itemIds = items.map((item) => item.id);
    if (itemIds.includes(newItem.id)) {
      items.map((item) => {
        if (item.id === newItem.id) {
          item.quantity = newItem.quantity;
          item.amount = newItem.amount;
        }
      });
    } else {
      items = [...items, newItem];
    }
    this.setState({items: items})
  }

  deleteFromBasket(newItem) {
    const items = this.state.items.filter((item) => {
      return item.id !== newItem.id;
    });
    this.setState({items: items})
  }

  updateItemQuantity(newItem) {
    let items = this.state.items;
    items.map((item) => {
      if (item.id === newItem.id) {
        item.quantity = newItem.quantity;
        item.amount = newItem.amount;
      }
    });
    this.setState({items: items})
  }

  render() {
    const { products, productsLoading, items, itemsLoading } = this.state;
    return (
      <div>
        <nav className="navbar navbar-light bg-light">
          <div className="container-fluid">
            <span className="navbar-brand mb-0 h1">Anurag's Cash Register HW</span>
          </div>
        </nav>
        <div className="container px-4">
          <div className="row gx-5">
            <div className="col">
              <Products
                products={products}
                loading={productsLoading}
                addToBasket={this.addToBasket}
              />
            </div>
            <div className="col">
              <Basket
                items={items}
                loading={itemsLoading}
                deleteFromBasket={this.deleteFromBasket}
                updateItemQuantity={this.updateItemQuantity}
              />
            </div>
          </div>
        </div>
      </div>
    )
  }
}