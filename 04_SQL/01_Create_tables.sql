CREATE DATABASE IF NOT EXISTS ecommerce_analytics;
USE ecommerce_analytics;

CREATE TABLE locations (
    location_id INT PRIMARY KEY,
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    region VARCHAR(50)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    gender VARCHAR(30),
    age INT,
    location_id INT,
    signup_date DATE,
    customer_segment VARCHAR(30),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(100),
    sub_category VARCHAR(100),
    brand VARCHAR(100),
    unit_price_inr DECIMAL(12,2),
    cost_price_inr DECIMAL(12,2),
    stock_status VARCHAR(30)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(30),
    sales_channel VARCHAR(50),
    coupon_code VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price_inr DECIMAL(12,2),
    discount_pct DECIMAL(5,2),
    line_sales_inr DECIMAL(14,2),
    line_cost_inr DECIMAL(14,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    payment_method VARCHAR(50),
    payment_status VARCHAR(30),
    payment_amount_inr DECIMAL(14,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE shipping (
    shipping_id INT PRIMARY KEY,
    order_id INT,
    shipping_location_id INT,
    courier_partner VARCHAR(50),
    shipping_date DATE,
    expected_delivery_date DATE,
    actual_delivery_date DATE,
    delivery_status VARCHAR(30),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (shipping_location_id) REFERENCES locations(location_id)
);

CREATE TABLE returns (
    return_id INT PRIMARY KEY,
    order_item_id INT,
    return_date DATE,
    return_reason VARCHAR(100),
    return_status VARCHAR(30),
    refund_amount_inr DECIMAL(14,2),
    FOREIGN KEY (order_item_id) REFERENCES order_items(order_item_id)
);

CREATE TABLE reviews (
    review_id INT PRIMARY KEY,
    order_item_id INT,
    customer_id INT,
    review_date DATE,
    rating INT,
    review_text VARCHAR(255),
    FOREIGN KEY (order_item_id) REFERENCES order_items(order_item_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);