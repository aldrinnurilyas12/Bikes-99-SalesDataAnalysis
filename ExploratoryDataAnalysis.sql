/* running sql for EDA */

-- USE biker99 database
USE biker99;

/* running table Transaction */
SELECT * FROM transactions;

/* Checking the duplicate rows*/
SELECT transaction_id
FROM transactions
GROUP BY transaction_id
HAVING COUNT(transaction_id) > 1;

/* Checking for null values */
SELECT 'transaction_id' as columnName , COUNT(*) AS nullCountValues
FROM transactions 
WHERE transaction_id is NULL
UNION 
SELECT 'product_id' as columnName, COUNT(*) AS nullCountValues
FROM transactions 
WHERE product_id is NULL
UNION 
SELECT 'customer_id' as columnName, COUNT(*) AS nullCountValues
FROM transactions 
WHERE customer_id is NULL
UNION 
SELECT 'transaction_date' as columnName, COUNT(*) AS nullCountValues
FROM transactions 
WHERE transaction_date is NULL
UNION 
SELECT 'online_order' as columnName, COUNT(*) AS nullCountValues
FROM transactions 
WHERE online_order is NULL
UNION 
SELECT 'order_status' as columnName, COUNT(*) AS nullCountValues
FROM transactions 
WHERE order_status is NULL
UNION 
SELECT 'brand' as columnName, COUNT(*) AS nullCountValues
FROM transactions 
WHERE brand is NULL
UNION 
SELECT 'product_line' as columnName, COUNT(*) AS nullCountValues
FROM transactions 
WHERE product_line is NULL
UNION 
SELECT 'product_class' as columnName, COUNT(*) AS nullCountValues
FROM transactions 
WHERE product_class is NULL
UNION 
SELECT 'product_size' as columnName, COUNT(*) AS nullCountValues
FROM transactions 
WHERE product_size is NULL
UNION 
SELECT 'list_price' as columnName, COUNT(*) AS nullCountValues
FROM transactions 
WHERE list_price is NULL;

/* Sales total by brand approved */
SELECT brand, count(transaction_id) as sales_total, order_status as status
FROM transactions
WHERE  order_status ='Approved' 
GROUP BY brand;

/* Sales total by brand cancelled */
SELECT brand, count(transaction_id) as sales_total, order_status as status
FROM transactions
WHERE  order_status ='Cancelled' 
GROUP BY brand;

/* Top Products Sales */
SELECT brand, COUNT(transaction_id) as total, SUM(list_price) as revenue_total
FROM transactions
WHERE order_status ='Approved'
GROUP BY brand
ORDER BY 'total' DESC;

/* Top Products Sales by product_size */
SELECT brand, COUNT(transaction_id) as total, SUM(list_price) as total_sales,product_size
FROM transactions
WHERE order_status ='Approved' AND product_size='medium'
GROUP BY brand
UNION
SELECT brand, COUNT(transaction_id) as total, SUM(list_price) as total_sales,product_size
FROM transactions
WHERE order_status ='Approved' AND product_size='large'
GROUP BY brand
UNION
SELECT brand, COUNT(transaction_id) as total, SUM(list_price) as total_sales,product_size
FROM transactions
WHERE order_status ='Approved' AND product_size='small'
GROUP BY brand
ORDER BY `total` DESC;

/* Top Products Sales by product_line */
SELECT  brand, COUNT(transaction_id) as total, SUM(list_price) as total_sales, product_line
FROM transactions
WHERE order_status ='Approved' AND product_line='road'
GROUP BY brand
UNION
SELECT brand, COUNT(transaction_id) as total, SUM(list_price) as total_sales, product_line
FROM transactions
WHERE order_status ='Approved' AND product_line='mountain'
GROUP BY brand
UNION
SELECT brand, COUNT(transaction_id) as total, SUM(list_price) as total_sales, product_line
FROM transactions
WHERE order_status ='Approved' AND product_line='standard'
GROUP BY brand
UNION
SELECT  brand, COUNT(transaction_id) as total, SUM(list_price) as total_sales, product_line
FROM transactions
WHERE order_status ='Approved' AND product_line='touring'
GROUP BY brand
ORDER BY `total` DESC;

/* Revenue Total */
SELECT SUM(list_price) as Revenue FROM transactions;

/* Profit */

SELECT  SUM(list_price) - SUM(standard_cost) as profit
FROM transactions
WHERE order_status='Approved';


/*CUSTOMERS SEGMENT */

SELECT * FROM customers;

/*Total Customers */
SELECT DISTINCT COUNT(customer_id) as total_customer FROM customers;

/*Cheking Duplicate Rows */
SELECT customer_id
FROM customers
GROUP BY customer_id
HAVING COUNT(customer_id) > 1;

/*Average the Customers age */
SELECT AVG(age) from customers;

/*Drop Column */
ALTER TABLE customers
DROP COLUMN past_3_years_bike_related_purchases;

/*Top 5 customers */
SELECT name, COUNT(transaction_id) as total_transaction 
FROM customers 
LEFT JOIN transactions ON customers.customer_id = transactions.customer_id 
WHERE order_status ='Approved' GROUP BY name ORDER BY `total_transaction` DESC LIMIT 5;

/*Top 10 Rank Customers by transaction */
SELECT name, COUNT(transaction_id) as total_transaction, SUM(list_price) as total_spent,  dense_rank() OVER(ORDER BY COUNT(transaction_id)DESC) AS RankNo
FROM customers 
LEFT JOIN transactions ON customers.customer_id = transactions.customer_id 
WHERE order_status ='Approved' GROUP BY name LIMIT 10;

/*Total customers by Segment */
SELECT COUNT(customer_id) as total_customer, wealth_segment
FROM customers
GROUP BY wealth_segment;
















