select * from sales_data sd 

--Calculate the total sales value across all orders.
select sum(quantity*price) as total_amount from sales_data sd

--Show total sales value by month.
select to_char(order_date,'YYYY-MM') as month,round(sum(quantity*price),2) as Total_sales
from sales_data sd 
group by to_char(order_date,'YYYY-MM')
order by month

--List the top 5 best-selling products based on total revenue
select product_name,sum(quantity*price) as Total_amount 
from sales_data sd 
group by product_name 
order by Total_amount desc 
limit 5


--	Show total sales value per region
select region,sum(quantity*price) as Total_Amount
from sales_data sd 
group by region 

-- Find the number of orders placed by each customer. Return top 10 most frequent buyers
select customer_id ,count(customer_id) as total_orders
from sales_data sd 
group by customer_id 
order by  total_orders desc 
limit 10

-- What percentage of total revenue does each product category contribute?
SELECT 
    category,
    ROUND(SUM(quantity * price), 2) AS category_revenue,
    ROUND(SUM(quantity * price) * 100.0 / 
          (SELECT SUM(quantity * price) FROM sales_data), 2) AS perc_total
FROM sales_data sd
GROUP BY category
ORDER BY perc_total DESC;

--Calculate how many customers have made more than one purchase.
SELECT COUNT(*) AS repeat_customers
FROM (
    SELECT customer_id
    FROM sales_data
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
) AS repeated;





