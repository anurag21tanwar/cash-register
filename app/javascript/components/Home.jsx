import React from "react";
import Products from "./Products";
import Basket from "./Basket";

export default () => (
    <div>
        <nav className="navbar navbar-light bg-light">
            <div className="container-fluid">
                <span className="navbar-brand mb-0 h1">Anurag's Cash Register HW</span>
            </div>
        </nav>
        <div className="container px-4">
            <div className="row gx-5">
                <div className="col">
                    <Products />
                </div>
                <div className="col">
                    <Basket />
                </div>
            </div>
        </div>
    </div>
);