
--- Question 1---
--What is the customer name, country, age and city for only customers that live--
--in the state of California and are over 25 years for the consumer segment.--
--Sort the result by age in asc order--

select 
	customer_name,
	country,
	age,
	city
from customer
where state = 'California'
and age > 25
and segment = 'Consumer'
order by age; 



------ Question 2---  
--Display the total count of customers by segment--

select
	count(customer_id),
	segment
from customer
group by 2;


------ Question 3---
--Write a query to categorize profit that are below 100 as Low Margin, within the range--
-- of 100 - 300 as Mid Margin then every other profit that doesn't fall in either of both--
--categories as High for all orders purchased in 2016. Display the result for only the top 20--

select
	profit,
case 
	when profit < 100 then 'Low Margin'
	when profit between 100 and 300 then 'Mid Margin'
	else 'High Margin'
end as profit_category
from sales
where order_date between '2016-01-01' and '2016-12-31'
order by profit desc
limit 20;



------ Question 4---
--Calculate the total sales for each region in the last 7 years--

select
	sum(s.sales) as total_sales,
	c.region
from sales as s
inner join customer as c
on s.customer_id = c.customer_id
where order_date >= current_date - Interval '7 years'
group by 2;



----- Question 5---
--What is the total number of orders that were not shipped with first class and --
--standard class. sort the result by the ship mode--

select 
	count(order_id),
	ship_mode
from sales
where ship_mode not in ('First Class', 'Standard Class')
group by 2
order by 2;


----- Question 6---
--Write a query to show the ship mode, ship_date, total sales, profits --
--and order quantity for all orders that were shipped the earliest and latest--
	
	Shipped Latest
SELECT ship_mode,
       ship_date,
       SUM(sales) AS total_sales,
       SUM(profit) AS total_profit,  
       SUM(quantity) AS order_quantity
FROM sales
WHERE ship_date = (
  SELECT MAX(ship_date)
  FROM sales
)
GROUP BY ship_mode, ship_date;


	Shipped Earliest
SELECT ship_mode,
       ship_date,
       SUM(sales) AS total_sales,
       SUM(profit) AS total_profit,  
       SUM(quantity) AS order_quantity
FROM sales
WHERE ship_date IN (
  SELECT MIN(ship_date)
  FROM sales
)
GROUP BY ship_mode, ship_date;


--- Question 7---
--Write a query that returns all the orders that are above 1000 in sales, --
--from only first class ship mode and are shipped between may and june 2015--

select
	order_id,
	sales,
	ship_mode
from sales
where sales > 1000
and ship_mode = 'First Class'
and ship_date between '2015-01-01' and '2015-12-31';
	

--- Question 8---
--Write a query for the top 10 orders by fetching customer name, age, --
--state, total sales, total profit,product category and sub category --
--for only orders placed in 2016 in all states excluding Florida & Utah--

select
	c.customer_name,
	c.age,
	c.state,
	sum(s.sales) as total_sales,
	sum(s.profit) as total_profit,
	p.category,
	p.sub_category
from customer as c
inner join sales as s
on s.customer_id = c.customer_id
inner join product as p
on p.product_id = s.product_id
where order_date between '2016-01-01' and '2016-12-31' 
and state not in ('Florida', 'Utah')
group by 1,2,3,6,7
order by total_sales desc
limit 10;


----- Question 9---
--Write a query to pull customer_id, age, city, sales,profits, ship mode and ship date 
--of transactions purchased in 2017, for all states excluding California, New York and texas,--
--city does not include null and customer’s age group of 20-60. sort the result in descending order--

select 
	c.customer_id,
	c.age,
	s.sales,
	s.profit,
	s.ship_mode,
	s.ship_date
from customer as c
inner join sales as s
on s.customer_id = c.customer_id
where order_date between '2017-01-01' and '2017-12-31' 
and state not in ('California', 'New york', 'Texas')
and city is not null
and age between 20 and 60
order by sales desc;


------ Question 10---
--Write a query to show the average age of customers,include their region and city --
--and total number of orders quantities for orders purchased in 2017 for all customers--
--excluding customers in texas. Sort by region--

select 
	avg(c.age) as average_age,
	c.region,
	c.city,
	sum(s.quantity) as total_qty
from customer as c
inner join sales as s
on s.customer_id = c.customer_id
where order_date between '2017-01-01' and '2017-12-31' 
and state not in ('Texas')
group by 2,3
order by region;



--------- Question 11---
--Find the top 10 products with the highest profit margin in the last 7 years--


select 
	p.product_name as most_profitable,
	round(s.profit/s.sales), 2 as profit_margin
from product as p
inner join sales as s
on p.product_id = s.product_id
where order_date >= current_date - interval '7 years'
order by profit_margin desc
limit 10;


------ Question 12---
--Get the top 10 best-selling products in the last 7 years--

select 
	p.product_name as most_profitable,
	sum(s.sales) as top_selling
from product as p
inner join sales as s
on p.product_id = s.product_id
where order_date >= current_date - interval '7 years'	
group by 1
order by 2 desc
limit 10;



