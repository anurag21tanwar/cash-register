import React, { useState, useEffect } from "react";
import Loader from './Loader';
import { Link } from "react-router-dom";

const totalAmount = (basket) => {
    return basket.reduce((sum, item) => sum + parseFloat(item.amount), 0).toFixed(2);
};

const Basket = () => {
    const [basket, setBasket] = useState({});
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const url = `/api/v1/basket/${currentBasketId}`;
        fetch(url)
            .then(response => {
                if (response.ok) {
                    return response.json();
                }
                throw new Error("Network response was not ok.");
            })
            .then(response => {
                setBasket(response.items);
                setLoading(false);
            })
            .catch(() => this.props.history.push("/"));
    }, []);

    return (
        <>
            <div className="py-5">
                <div className="text-right mb-3" />
                <h4 className="card-title">Basket</h4>
                <div className="row">
                    {
                        loading ? <Loader /> :
                            basket.length > 0 ? (
                                    <>
                                        <table className="table table-striped">
                                            <thead>
                                            <tr>
                                                <th>Code</th>
                                                <th>Quantity</th>
                                                <th>Amount</th>
                                                <th />
                                            </tr>
                                            </thead>
                                            <tbody>
                                            { basket.map((item, index) => (
                                                <tr key={index}>
                                                    <td>{item.code}</td>
                                                    <td>
                                                        <span>
                                                            <Link to="#" onClick={() => decreaseQuantity(item.product_id)} className="btn">
                                                                <i className="bi bi-caret-left-fill"></i>
                                                            </Link>
                                                        </span>{item.quantity}
                                                        <span>
                                                            <Link to="#" onClick={() => increaseQuantity(item.product_id)} className="btn">
                                                                <i className="bi bi-caret-right-fill"></i>
                                                            </Link>
                                                        </span>
                                                    </td>
                                                    <td>{`€${item.amount}`}</td>
                                                    <td><Link to="#" onClick={() => removeFromBasket(item.product_id)} className="btn">
                                                        <i className="bi bi-trash"></i>
                                                    </Link></td>
                                                </tr>))
                                            }
                                            <tr>
                                                <td>Total Amount</td>
                                                <td />
                                                <td>{`€${totalAmount(basket)}`}</td>
                                                <td />
                                            </tr>
                                            </tbody>
                                        </table>
                                    </>
                                )
                                : (
                                    <div
                                        className="d-flex align-items-center justify-content-center">
                                        <h6>Nothing added in basket yet!</h6>
                                    </div>
                                )
                    }
                </div>
            </div>
        </>
    )
};

export default Basket;