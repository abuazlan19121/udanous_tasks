SELECT * from customers
SELECT * FROM orders
SELECT * FROM products

SELECT first_name,last_name,city FROM customers

SELECT concat(first_name,' ',last_name) as full_name,product_name,price*quantity as total_amount
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN products p ON o.product_id=p.product_id

SELECT * FROM orders
WHERE extract(MONTH from order_date)=03

SELECT product_id,count(product_id)
FROM orders
GROUP BY product_id
ORDER BY product_id ASC

SELECT p.product_name,p.price*o.quantity as total_revenue
FROM orders o
JOIN products p ON o.product_id=p.product_id
GROUP BY p.product_name,"total_revenue"


SELECT c.customer_id,c.first_name,c.last_name,sum(p.price*o.quantity) as total_spent
FROM orders o
JOIN products p ON o.product_id=p.product_id
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id,c.first_name,c.last_name
ORDER BY total_spent DESC

SELECT city,max(p.price*o.quantity) FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN products p ON o.product_id=p.product_id
GROUP BY city