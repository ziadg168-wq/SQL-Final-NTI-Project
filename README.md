# BikeStore Database Analysis

## Project Overview

This project analyzes the **BikeStore Database** using Microsoft SQL Server and SQL Server Management Studio (SSMS).

The analysis was completed using SQL queries against the BikeStore database to explore customers, orders, products, categories, brands, stores, staff, inventory, and sales performance.

The project follows the questions and requirements provided in the project brief.

## Objectives

The main objectives of this project are to:

- Explore the BikeStore database and its tables.
- Analyze products, categories, brands, customers, orders, and stores.
- Calculate order totals and store revenue.
- Identify sales patterns and inventory information.
- Analyze rejected and pending orders.
- Retrieve specific customer, product, staff, and store information.
- Practice SQL joins, aggregation, filtering, grouping, subqueries, and date functions.

## Database Tables

The SQL analysis uses the following BikeStore tables:

### Production Schema

- `production.brands`
- `production.categories`
- `production.products`
- `production.stocks`

### Sales Schema

- `sales.customers`
- `sales.order_items`
- `sales.orders`
- `sales.staffs`
- `sales.stores`

## Order Status

The project brief defines the following order-status values:

| Status | Meaning |
|---:|---|
| 1 | Pending |
| 2 | Processing |
| 3 | Rejected |
| 4 | Completed |

## Project Questions

The SQL script addresses the following 24 questions:

1. Identify the most expensive bike and discuss the possible reason for its high price.
2. Determine the total number of customers and evaluate whether customers with rejected orders should be considered customers.
3. Count the number of BikeStore stores.
4. Calculate the total price spent per order.
5. Calculate sales/revenue per store.
6. Identify the category with the highest quantity sold.
7. Identify the category with the most rejected orders.
8. Identify the least-sold bikes.
9. Find the full name of customer ID `259`.
10. Determine what customer `259` purchased, when the order was placed, and its status.
11. Identify the staff member who processed customer `259`'s order and the store where it was processed.
12. Count BikeStore staff and identify staff members without a manager.
13. Identify the brand with the highest quantity sold.
14. Count the product categories and identify the least-sold category.
15. Identify the store with the highest in-stock quantity of the most-sold brand.
16. Identify the state with the highest sales revenue.
17. Calculate the discounted price of product ID `259`.
18. Retrieve product `44` information, including product name, stock quantity, price, category, model year, and brand.
19. Find the ZIP code(s) of stores located in California (`CA`).
20. Count the number of states in which BikeStore operates.
21. Calculate the number of Children's Bicycles sold during the last eight months relative to the most recent order date in the database.
22. Find the shipped date for orders belonging to customer `523`.
23. Count the number of orders that are still pending.
24. Identify the category and brand of **Electra White Water 3i - 2018**.

## Key SQL Techniques Used

The analysis demonstrates several important SQL concepts:

- `SELECT`
- `WHERE`
- `JOIN`
- `LEFT JOIN`
- `GROUP BY`
- `ORDER BY`
- `TOP`
- `COUNT()`
- `SUM()`
- `ISNULL()`
- `DISTINCT`
- Aggregate calculations
- Subqueries
- `DATEADD()`
- String concatenation
- Filtering by order status
- Inventory and sales calculations

## Important Calculations

### Total Price per Order

The project defines total order price as:

```sql
list_price * quantity * (1 - discount)
```

### Store Revenue

Store revenue is calculated using the same formula:

```sql
SUM(list_price * quantity * (1 - discount))
```

### Discounted Product Price

The discounted unit price is calculated as:

```sql
list_price * (1 - discount)
```

### Last 8 Months

For the Children's Bicycles analysis, the eight-month period is calculated relative to the most recent order date in the database:

```sql
DATEADD(month, -8, (SELECT MAX(order_date) FROM sales.orders))
```

This makes the analysis relative to the data available in the database rather than the current calendar date.

## How to Run the Project

### Requirements

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- BikeStore Database
- The provided SQL script: `SQLQuery1.sql`

### Steps

1. Install and open SQL Server and SSMS.
2. Load/restore the BikeStore database.
3. Open `SQLQuery1.sql` in SSMS.
4. Make sure the correct BikeStore database is selected.
5. Execute the queries.
6. Review the results for each question.
7. Use the query results together with the comments in the SQL script to document the analysis.

## Project Structure

```text
BikeStore-Database-Analysis/
│
├── SQLQuery1.sql
├── Project Details.pdf
└── README.md
```

## Notes

- The SQL script begins with an exploration section that displays all records from the main BikeStore tables.
- Rejected orders use `order_status = 3`.
- Pending orders use `order_status = 1`.
- The customer analysis excludes rejected orders when counting customers, according to the project's SQL logic.
- The least-sold bike query identifies products that were sold exactly once; products with zero sales are not included in that particular query.
- The "lead staff" query identifies staff members whose `manager_id` is `NULL`.
- The most-liked brand is interpreted in the SQL analysis as the brand with the highest quantity sold.
- The least-liked category is interpreted as the category with the lowest total quantity sold.

## Files

### `SQLQuery1.sql`

Contains the complete SQL solution for the 24 project questions, including data exploration and analytical queries.

### `Project Details.pdf`

Contains the original project requirements and the 24 BikeStore analysis questions.

## Author

**BikeStore Database Analysis Project**

Built as a SQL Server database analysis project using the BikeStore sample database.
