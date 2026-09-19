14. -- Rank all products based on their total sales revenue.

SELECT p.product_id,  
	   p.product_name, 
       SUM(oi.line_sales_inr) as total_sales_revenue,
RANK() OVER(
        ORDER BY sum(oi.line_sales_inr) DESC 
) AS sales_rank

FROM order_items oi JOIN products p ON oi.product_id = p.product_id 


GROUP BY p.product_id, 
         p.product_name 
ORDER BY 
      sales_rank ;

15.-- Find the top 3 products by sales revenue within each product category.

with product_sales AS (SELECT 
    p.product_id,
    p.product_name,
    p.category,
    SUM(line_sales_inr) AS sales_revenue
FROM
    order_items oi
        JOIN
    products p ON oi.product_id = p.product_id
GROUP BY 
	p.product_id, 
	p.product_name,
	p.category
),

ranked_products AS (
    SELECT 
        product_id,
        product_name,
        category,
        sales_revenue,
        RANK() OVER(
        PARTITION BY category
        ORDER BY sales_revenue DESC
        ) AS sales_rank FROM product_sales
)

SELECT 
      product_id,
      product_name,
      category,
	  sales_revenue,
      sales_rank
FROM ranked_products
WHERE sales_rank <= 3
ORDER BY
      category,
      sales_rank;


16. -- Find customers whose total spending is higher than the average spending of all customers.

WITH customer_spending AS(
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(oi.line_sales_inr) AS total_spending
FROM
    order_items oi
        JOIN
    orders o ON oi.order_id = o.order_id
        JOIN
    customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, 
		 c.customer_name
),

average_spending AS (
       SELECT 
         AVG(total_spending) AS avg_spending
		FROM customer_spending
)

SELECT 
      cs.customer_id,
      cs.customer_name,
      cs.total_spending,
      a.avg_spending
      
FROM customer_spending cs CROSS JOIN average_spending a 
WHERE cs.total_spending > a.avg_spending
ORDER BY 
    cs.total_spending DESC;

17.-- Calculate the return rate for each product category.

SELECT 
    p.category,
    COUNT(r.order_item_id) AS returned_items,
    COUNT(oi.order_item_id) AS total_items,
    ROUND(COUNT(DISTINCT r.order_item_id) * 100.0 / COUNT(DISTINCT oi.order_item_id),
            2) AS return_rate_pct
FROM
    products p
        JOIN
    order_items oi ON p.product_id = oi.product_id
        LEFT JOIN
    returns r ON oi.order_item_id = r.order_item_id
GROUP BY p.category
ORDER BY return_rate_pct DESC ;

18. -- Rank customers by their total sales revenue within each region.

WITH customer_sales AS (
SELECT 
    c.customer_id,
    c.customer_name,
    l.region,
    SUM(line_sales_inr) AS total_sales_revenue
FROM
    order_items oi
        JOIN
    orders o ON oi.order_id = o.order_id
        JOIN
    customers c ON o.customer_id = c.customer_id
        JOIN
    locations l ON c.location_id = l.location_id
GROUP BY c.customer_id , c.customer_name , l.region

)

SELECT 
      customer_id,
      customer_name,
      region,
      total_sales_revenue,
      RANK() OVER( 
      PARTITION BY region
      ORDER BY total_sales_revenue DESC
      ) AS sales_rank
FROM customer_sales
ORDER BY 
       region,
	   sales_rank ;

19. -- Based on sales, profit, discounts, returns, ratings, and delivery performance, 
-- which areas should management prioritize for improvement?

USE ecommerce_analytics;

WITH region_sales AS (
    SELECT
        l.region,
        SUM(oi.line_sales_inr) AS total_sales,
        SUM(oi.line_sales_inr - oi.line_cost_inr) AS total_profit,
        AVG(oi.discount_pct) AS avg_discount
    FROM customers c
    JOIN locations l
        ON c.location_id = l.location_id
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY l.region
),

region_returns AS (
    SELECT
        l.region,
        COUNT(DISTINCT r.order_item_id) AS returned_items,
        COUNT(DISTINCT oi.order_item_id) AS total_items
    FROM customers c
    JOIN locations l
        ON c.location_id = l.location_id
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    LEFT JOIN returns r
        ON oi.order_item_id = r.order_item_id
    GROUP BY l.region
),

region_ratings AS (
    SELECT
        l.region,
        AVG(rv.rating) AS avg_rating
    FROM customers c
    JOIN locations l
        ON c.location_id = l.location_id
    JOIN reviews rv
        ON c.customer_id = rv.customer_id
    GROUP BY l.region
),

region_delivery AS (
    SELECT
        l.region,
        COUNT(s.shipping_id) AS total_deliveries,
        SUM(
            CASE
                WHEN s.actual_delivery_date > s.expected_delivery_date
                THEN 1
                ELSE 0
            END
        ) AS late_deliveries
    FROM customers c
    JOIN locations l
        ON c.location_id = l.location_id
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN shipping s
        ON o.order_id = s.order_id
    GROUP BY l.region
),

metrics AS (
    SELECT
        rs.region,
        rs.total_sales,
        rs.total_profit,
        rs.avg_discount,

        ROUND(
            rr.returned_items * 100.0 / NULLIF(rr.total_items, 0),
            2
        ) AS return_rate_pct,

        ROUND(rs2.avg_rating, 2) AS avg_rating,

        ROUND(
            rd.late_deliveries * 100.0 / NULLIF(rd.total_deliveries, 0),
            2
        ) AS late_delivery_rate_pct

    FROM region_sales rs
    JOIN region_returns rr
        ON rs.region = rr.region
    LEFT JOIN region_ratings rs2
        ON rs.region = rs2.region
    LEFT JOIN region_delivery rd
        ON rs.region = rd.region
),

ranked AS (
    SELECT
        *,
        
        RANK() OVER (
            ORDER BY total_sales ASC
        ) AS sales_priority,

        RANK() OVER (
            ORDER BY total_profit ASC
        ) AS profit_priority,

        RANK() OVER (
            ORDER BY avg_discount DESC
        ) AS discount_priority,

        RANK() OVER (
            ORDER BY return_rate_pct DESC
        ) AS return_priority,

        RANK() OVER (
            ORDER BY avg_rating ASC
        ) AS rating_priority,

        RANK() OVER (
            ORDER BY late_delivery_rate_pct DESC
        ) AS delivery_priority

    FROM metrics
)

SELECT
    region,
    total_sales,
    total_profit,
    ROUND(avg_discount, 2) AS avg_discount,
    return_rate_pct,
    avg_rating,
    late_delivery_rate_pct,

    (
        sales_priority
        + profit_priority
        + discount_priority
        + return_priority
        + rating_priority
        + delivery_priority
    ) AS improvement_priority_score

FROM ranked
ORDER BY
    improvement_priority_score DESC;
