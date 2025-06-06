

-- Data cleaning

select * 
from 
	retail_sales 
where 
	transactions_id is null;

select * 
from 
	retail_sales 
where 
	sale_date is null;

select * 
from 
	retail_sales 
where
	transactions_id is null or
	sale_date is null or
	sale_time is null or
	customer_id is null or
	gender is null or
	age is null or
	category  is null or
	quantiy is null or
	price_per_unit is null or
	cogs is null or
	total_sale is null;


delete 
from 
 	retail_sales 
where
	transactions_id is null or
	sale_date is null or
	sale_time is null or
	customer_id is null or
	gender is null or
	age is null or
	category  is null or
	quantiy is null or
	price_per_unit is null or
	cogs is null or
	total_sale is null;

select 
	count(*) 
from 
	retail_sales;

--Data Exploration

select * 
from 
	retail_sales;

--How many sales we have?
select 
	count(*) as total_sales 
from 
	retail_sales;

--How many unique customers we have?
select 
	count(distinct customer_id) as total_customers 
from 
	retail_sales;

--How many categories we have?
select 
	count(distinct category) total_categories 
from 
	retail_sales;


--Data Analysis & Bussiness Key Problems-Answers

--Write SQL query to retrive all columns for sales made on 2022-11-05

select * 
from 
	retail_sales 
where 
	sale_date='2022-11-05';

--Write a SQL query to retrive all transactions where the category is "Clothing" and the quantity sold is more than 4 in the month of NOV-2022

select * 
from 
	retail_sales
where 
	category= 'Clothing'
	and TO_CHAR(sale_date, 'YYYY-MM')='2022-11'
	and quantity >=4;

--Write a SQL Query to calculate the total sales as total_sale for each category
select 
	category,
	sum(total_sale) as total_sale , 
	count(*) as total_orders
from 
	retail_sales
group by category;

--Write a SQL query to find the average age of customer who purchased items from the 'Beauty' category.
select 
	round(avg(age),2) as average_age
from 
	retail_sales
where 
	category='Beauty';

--Write a SQL query to find all transactions where the total_sale is greater than 1000.
select *
from 
	retail_sales
where 
	total_sale>1000;

--Write SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select 
	category,
	gender,
	count(transactions_id)
from
	retail_sales 
group by
	category,
	gender
order by 1;

--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
select 
	year,
	month,
	avg_sale 
from(
	select
		extract(year from sale_date) as year,
		extract(month from sale_date) as month,
		avg(total_sale) as avg_sale,
		rank() over(partition by extract (year from sale_date) order by avg(total_sale) desc) as rank
	from 
		retail_sales
	group by 1,2) as t1
where rank=1;

--Write a SQL query to find the top 3 customers based on the highest total sale.
select 
	customer_id,
	sum(total_sale) as total_sales
from 
	retail_sales
group by 1
order by 2 desc
limit 3;

--Write a SQL Query to find the number of unique customers who purchased items from each category
select
	category,
	count(distinct customer_id) as total_customers
from 
	retail_sales
group by 1;

--Write a SQL Query to create each shift and number of orders (Example Morning<12, Afternoon Between 12&17, Evening>17)
select
	case
		when extract(hour from sale_time)<12 then 'Morning'
		when extract(hour from sale_time )between 12 and 17 then 'Afternoon'
		else 'Evening'
	end as shift,
	count(*) as total_no_of_orders
from 
	retail_sales
group by shift;

--End of project









