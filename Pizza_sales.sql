create database Pizza_SALES;
use Pizza_SALES;

CREATE TABLE pizza_sales (
    pizza_id INT PRIMARY KEY,
    order_id INT,
    pizza_name_id VARCHAR(50),
    quantity INT,
    order_date DATE, 
    order_time TIME,
    unit_price DECIMAL(10,2),
    total_price DECIMAL(10,2),
    pizza_size VARCHAR(10),
    pizza_category VARCHAR(50),
    pizza_ingredients VARCHAR(250),
    pizza_name VARCHAR(100)
);


select * from pizza_sales;



-- DATA EXLORATION



-- count of rows
select count(*) from pizza_sales;

-- sample data
select * from pizza_sales limit 5;

-- NULL values
select * from pizza_sales 
where pizza_id is NULL or
order_id is NULL or
pizza_name_id is NULL or
quantity is NULL or
order_date is NULL or
order_time is NULL or
unit_price is NULL or
total_price is NULL or
pizza_size is NULL or
pizza_category is NULL or
pizza_ingredients is NULL or
pizza_name is NULL;




-- Business Insights  ----->



-- KPI's ------------------>


-- 1--> Found Total Revenue = The sum of the total price of all pizza orders
select sum(total_price) as Total_Revenue from pizza_sales;


-- 2--> Found Average_order_value = the AVG amount earned per order
select (sum(total_price) / 
(select count(distinct order_id) from pizza_sales))
as AVG_Order_Value 
from pizza_sales;


-- 3--> Found Total Pizza Sold = the sum of quantities of all sold pizzas
select sum(quantity) as Total_Pizzas_Sold from pizza_sales;


-- 4--> Found Total Orders = Total no. of orders placed
select count(distinct order_id) as Total_Orders from pizza_sales ;


-- 5--> Found AVG_Pizza_per_Order 
select cast(cast(sum(quantity) as decimal(10,1)) /
cast(count(distinct order_id) as decimal(10,1)) as decimal(10,1))
as AVG_Pizza_per_Order
from pizza_sales;




-- CHARTS FOR EXCEL -----------------------> 


-- 1--> Daily Trend for Total Orders = DAYWISE
select dayname(order_date) as order_day , count(distinct order_id) as total_orders
from pizza_sales
group by dayname(order_date) 
order by count(distinct order_id) desc;


-- 2--> Hourly Trend for Total Orders = HOURWISE
select  hour(order_time) as order_hour ,count(distinct order_id) as total_orders
from pizza_sales
group by hour(order_time); 


-- 3--> % of Sales by Pizza Category
select pizza_category , cast(sum(total_price) as decimal(10,2)) as total_SALES , cast(sum(total_price)/
(select sum(total_price) from pizza_sales) * 100 as decimal(10,2))
as Sales_percentage
from pizza_sales
group by pizza_category;


-- 4--> % of Sales by Pizza Size
select pizza_size , cast(sum(total_price) as decimal(10,2)) as total_SALES , cast(sum(total_price)/
(select sum(total_price) from pizza_sales) * 100 as decimal(10,2))
as Sales_percentage
from pizza_sales
group by pizza_size;


-- 5--> Total Pizzas Sold by Pizza Category
select pizza_category , sum(quantity) as total_pizza_sold
from pizza_sales
group by pizza_category;


-- 6--> Top 5 Best Sellers by Total Pizzas Sold
select pizza_name , sum(quantity) as total_pizza_sold
from pizza_sales
group by pizza_name
order by total_pizza_sold desc
limit 5;


-- 7--> Bottom 5 Best Sellers by Total Pizzas Sold
select pizza_name , sum(quantity) as total_pizza_sold
from pizza_sales
group by pizza_name
order by total_pizza_sold 
limit 5;
