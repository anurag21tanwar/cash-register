import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import Loader from './Loader';

const Products = () => {
    const [products, setProducts] = useState({});
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const url = "/api/v1/products";
        fetch(url)
            .then(response => {
                if (response.ok) {
                    return response.json();
                }
                throw new Error("Network response was not ok.");
            })
            .then(response => {
                setProducts(response);
                setLoading(false);
            })
            .catch(() => this.props.history.push("/"));
    }, []);

    return (
        <>
            <div className="py-5">
                <div className="text-right mb-3" />
                <h4 className="card-title">Products Registered</h4>
                <div className="row">
                    {
                        loading ? <Loader /> :
                            products.length > 0 ?
                                products.map((product, index) => (
                                    <div key={index} style={{width: '15rem'}}>
                                        <div className="card">
                                            <div className="card-body">
                                                <h5 className="card-title">{product.name}</h5>
                                                <p className="card-text">{`Code: ${product.code}`}</p>
                                                <Link to={`#`} className="btn btn-primary">
                                                    Add to Basket
                                                </Link>
                                            </div>
                                        </div>
                                        <br />
                                    </div>
                                )) : (
                                    <div
                                        className="vw-100 vh-50 d-flex align-items-center justify-content-center">
                                        <h4>No products registered yet!</h4>
                                    </div>
                                )
                    }
                </div>
            </div>
        </>
    )
};

export default Products;