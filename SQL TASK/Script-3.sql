select * from customers c 
select * from order_items
select * from orders o 
select * from products p

---Monthly Revenue
select to_char(order_date,'YYYY,MM') as month,sum(total_amount) as Revenue
from orders o
group by "month"

---Customer lifetime value
select customer_id,sum(total_amount) as Lifetime_value  
from orders o 
group by customer_id 
order by "lifetime_value" desc 
limit 5

--Most Popular product by Region
SELECT DISTINCT ON (c.region)
  c.region,
  p.product_id,
  p.product_name,
  COUNT(*) OVER (PARTITION BY c.region, p.product_id) AS order_count
FROM customers c
  JOIN orders o ON c.customer_id = o.customer_id
  JOIN order_items oi ON o.order_id = oi.order_id
  JOIN products p ON oi.product_id = p.product_id
ORDER BY c.region,order_count desc

--Profit Analysis
select 
	p.product_name,
	sum((oi.price - p."cost")*oi.quantity) as total_profit
from order_items oi 
join products p on oi.product_id = p.product_id
group by p.product_name 
order by "total_profit" desc 
limit 5

-- New vs Returning Customers
with customer_type as(
	select date_trunc('month',order_date) as month,
	customer_id,
	case 
		when order_date = min(order_date) over(partition by customer_id)
		then 'New'
		else 'Returning'
	end as Type
	from orders o 
)
select 
	to_char(month,'YYYY,MM')as month,
	type,
	count(*) as orders 
from customer_type
group by month,type
order by month,type
