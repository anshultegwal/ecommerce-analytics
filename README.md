# E-Commerce Analytics Project

## 📌 Project Overview

This project is an end-to-end **E-Commerce Analytics** project built to analyze sales, customers, products, discounts, returns, reviews, and delivery performance.

The project was completed in three main stages:

1. **Python & Pandas** – Data exploration and preprocessing
2. **SQL** – Data analysis using queries, joins, aggregations, ranking, and business questions
3. **Power BI** – Interactive dashboard development and business insights

The goal of the project is to transform raw e-commerce data into meaningful insights that can support business decision-making.

---

## 🛠️ Tools & Technologies

- **Python**
  - Pandas
  - Data Cleaning
  - Data Exploration
- **SQL**
  - Joins
  - GROUP BY & Aggregations
  - Subqueries
  - CTEs
  - Window Functions
  - CASE statements
- **Power BI**
  - Data Modeling
  - DAX Measures
  - Calculated Metrics
  - Interactive Visualizations
  - Slicers & Filters
  - Dashboard Design

---

## 🗂️ Dataset

The project uses an `ecommerce_analytics` database containing **9 related tables**:

| Table | Description |
|---|---|
| `customers` | Customer details and customer segments |
| `locations` | Customer location information |
| `orders` | Order-level information including order dates |
| `order_items` | Products, quantities, prices, discounts, cost, and sales |
| `products` | Product and category information |
| `payments` | Payment-related information |
| `returns` | Returned order/product information |
| `reviews` | Customer reviews and ratings |
| `shipping` | Shipping and delivery information |

### Important Columns

Some important fields used during the analysis include:

- `customers.customer_id`
- `customers.customer_name`
- `customers.gender`
- `customers.age`
- `customers.location_id`
- `customers.signup_date`
- `customers.customer_segment`
- `orders.order_date`
- `order_items.product_id`
- `order_items.quantity`
- `order_items.unit_price_inr`
- `order_items.discount_pct`
- `order_items.line_cost_inr`
- `order_items.line_sales_inr`

---

# 🔹 Project Workflow

## 1. Python & Pandas

The first stage focused on understanding and preparing the dataset using Python and Pandas.

### Tasks included:

- Loading the datasets
- Exploring table structure
- Checking columns and data types
- Understanding missing values
- Inspecting duplicate records
- Performing basic data analysis
- Preparing the data for further analysis

---

## 2. SQL Analysis

After the initial data exploration, SQL was used to answer business-oriented questions.

### Key Analysis Performed

#### Sales Analysis
- Revenue by region
- Monthly revenue
- Product revenue
- Sales and profit analysis
- Category-level performance

#### Product Analysis
- Product ranking by revenue
- Top 3 products within each category
- Top-performing products

#### Customer Analysis
- Customers spending above average
- Customers with more than one order
- Customer ranking by sales within region
- Customer purchase behavior

#### Return Analysis
- Return rate by product category

#### Business Performance Analysis
The analysis also looked at:

- Sales
- Profit
- Discounts
- Returns
- Ratings
- Delivery performance

These analyses helped identify areas where business performance could be improved.

---

# 📊 Power BI Dashboard

The final stage of the project was an interactive Power BI dashboard built using the analyzed e-commerce data.

A dedicated **DateTable** was created using `orders[order_date]` and connected to the data model for time-based analysis.

## Dashboard Pages

### 1. Executive Overview

This page provides a high-level summary of overall business performance.

#### KPIs

- Total Customers
- Total Orders
- Total Quantity
- Average Order Value
- Total Sales

#### Visuals

- Yearly Sales & Profit Trend
- Sales by Category
- Sales by Region
- Top 5 Products by Sales

#### Slicers

- Region
- Category

---

### 2. Sales & Product Analysis

This page focuses on product and sales performance.

#### KPIs

- Total Sales
- Total Profit
- Total Quantity Sold
- Average Discount %
- Top Product Sales

#### Analysis

The page explores:

- Product-level sales performance
- Category performance
- Profitability
- Quantity sold
- Discount impact

The `discount_pct` field was analyzed carefully because **0% is a valid discount value and represents no discount; it is not a null value**.

---

### 3. Customer Analysis

This page focuses on customer purchasing behavior and customer-level performance.

#### Analysis Areas

- Total customers
- Customer purchasing behavior
- One-time customers
- Repeat customers
- Customer spending
- Order/customer relationships
- Category-level customer analysis

Customer purchase frequency was considered to distinguish customers making a single purchase from customers making multiple purchases.

---

### 4. Return, Review & Delivery Analysis

The final dashboard page focuses on post-purchase performance.

#### KPIs

- Return-related metrics
- Review/rating metrics
- Delivery metrics
- Total Refund Amount

#### Analysis Areas

- Returns
- Refunds
- Customer reviews
- Ratings
- Delivery performance

This page helps identify potential issues after an order has been placed.

---

# 📈 Key Business Areas Covered

The project provides analysis across the complete e-commerce lifecycle:

**Customer → Order → Product → Payment → Shipping → Review → Return**

This makes it possible to analyze not only sales but also customer behavior and post-purchase performance.

---

# 🎯 Business Questions Answered

Some of the major questions addressed in this project include:

- How many orders are present in the orders table?
- What is the total sales revenue generated from all order items?
- How many orders were placed through each sales channel?
- How much sales revenue was generated by each product category?
- Which 5 products generated the highest sales revenue?
- How much sales revenue was generated in each month?
- How many orders were placed by customers in each customer segment
- Which customers rank highest in sales within their region?
- Calculate the return rate for each product category.?
- Find customers whose total spending is higher than the average spending of all customers.
- Rank all products based on their total sales revenue.
- What areas can management focus on to improve business performance?

---

# 🧩 Data Model

The Power BI model connects the major business entities through their relevant keys.

A dedicated `DateTable` was also created to support:

- Year-based analysis
- Time trends
- Sales and profit analysis over time

The model was designed to allow filtering and interaction across the dashboard pages.

---

# 💡 Skills Demonstrated

This project demonstrates practical skills in:

- Data Cleaning
- Exploratory Data Analysis
- Python Pandas
- SQL
- Relational Data Modeling
- Complex SQL Queries
- Window Functions
- Business Analytics
- DAX
- Power BI Data Modeling
- KPI Development
- Dashboard Design
- Data Visualization
- Business Problem Solving

---

# 🚀 Project Outcome

The project successfully transforms raw e-commerce data into an interactive analytics solution.

The workflow demonstrates how data can be processed step-by-step:

**Raw Data → Python/Pandas → SQL Analysis → Power BI Dashboard → Business Insights**

This project can be used as a portfolio project to demonstrate end-to-end **Data Analyst / Business Intelligence** skills.

---

## 📁 Project Structure

A suggested project structure is:

```text
ecommerce-analytics/
│
├── data/
│   └── raw_dataset/
│
├── python/pandas
│   └── data_exploration.ipynb
│
├── data/
│   └── Clean dataset/
│
├── SQL/
│   └── queries/ (Basic, medium, Advance)
│
├── Power BI/
│   └── E-commerce_Analytics_dashboard.pbxi
│
├── Screeshots/
│   └── Power BI Dashboard Screenshots
│
├── documentation/
│   └── Business Questions
│
└── README.md
```
---
### Management Improvement Priorities

To identify areas that require management attention, regional performance was evaluated across **sales, profit, discounts, return rates, customer ratings, and delivery performance**.

A composite **Improvement Priority Score** was created using ranking-based analysis across all six business metrics. Regions with lower sales and profit, higher discounts, higher return rates, lower customer ratings, and higher late-delivery rates receive greater priority.

#### Key Business Insights

* **Sales & Profit:** Regions with comparatively lower sales and profit should be investigated to understand weak demand, product mix, or pricing-related issues.
* **Discount Management:** Regions with higher average discounts should be reviewed to determine whether discounts are generating sufficient sales and profit or unnecessarily reducing margins.
* **Returns:** Regions with higher return rates require investigation into product quality, product descriptions, sizing/specification issues, or customer expectations.
* **Customer Satisfaction:** Regions with lower average ratings indicate potential issues with product quality, service experience, or overall customer satisfaction.
* **Delivery Performance:** Regions with higher late-delivery rates should be reviewed for logistics, shipping-partner, inventory, or operational bottlenecks.
* **Overall Priority:** The combined priority score helps management identify regions where multiple performance indicators are simultaneously showing weaker outcomes, allowing resources and improvement efforts to be focused more effectively.

#### Management Action Areas

Based on these metrics, management can prioritize:

1. Improving sales and profitability in weaker-performing regions.
2. Optimizing discount strategies to protect profit margins.
3. Reducing product returns by identifying recurring product-related issues.
4. Improving customer experience in regions with lower ratings.
5. Strengthening logistics and delivery operations where late deliveries are higher.

**Business Value:**
This analysis provides management with a data-driven framework for identifying regional improvement opportunities rather than evaluating performance using sales alone.

---
##  👤 About

This project was created as part of a **Data Analytics portfolio** to demonstrate practical skills in python(pandas),SQL, Power BI relational data analysis, business problem solving, and dashboard creation.

The project focuses on applying data analytics concepts to a realistic E-commerce Analysis scenario and presenting the results in a clear, professional, and decision-oriented format.
