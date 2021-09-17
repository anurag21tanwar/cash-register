import React, { useState, useEffect } from "react";
import Loader from './Loader';

const Basket = () => {
    const [basket, setBasket] = useState({});
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const url = "/api/v1/basket";
        fetch(url)
            .then(response => {
                if (response.ok) {
                    return response.json();
                }
                throw new Error("Network response was not ok.");
            })
            .then(response => {
                setBasket(response);
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
                            basket.length > 0 ?
                                basket.map((item, index) => (
                                    <div key={index} style={{width: '15rem'}}>
                                        <div className="card">
                                            <div className="card-body">
                                                <h5 className="card-title">{item.code}</h5>
                                                <p className="card-text">{`Code: ${item.price}`}</p>
                                            </div>
                                        </div>
                                    </div>
                                )) : (
                                    <div
                                        className="vw-100 vh-50 d-flex align-items-center justify-content-center">
                                        <h4>Nothing added in basket yet!</h4>
                                    </div>
                                )
                    }
                </div>
            </div>
        </>
    )
};

export default Basket;