 1.-- How many orders are present in the orders table?

SELECT 
    COUNT(order_id)
FROM
    orders ;

2.-- What is the total sales revenue generated from all order items?

SELECT 
    SUM(line_sales_inr)
FROM
    order_items;

3.-- What is the average customer rating given.

SELECT 
    AVG(rating)
FROM
    reviews;

4.-- How many orders were placed through each sales channel?

SELECT 
    sales_channel, COUNT(order_id) AS total_orders
FROM
    orders
GROUP BY sales_channel;

5.-- How many customers are there in each gender category?

SELECT 
    gender, COUNT(customer_id) AS total_customers
FROM
    customers
GROUP BY gender; 

6.-- Show the order ID, order date, and customer name for every order.

SELECT 
    customer_name, order_id, order_date
FROM
    orders o
        JOIN
    customers c ON o.customer_id = c.customer_id;

