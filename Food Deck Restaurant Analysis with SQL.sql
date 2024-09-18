use sql_project;
select * from orders;
select * from restaurants;

-- Checking for Duplicates --
select OrderID,count(*) from orders
group by OrderID
having count(*) >1;
select RestaurantID,count(*) from restuarants
group by RestaurantID
having count(*) >1;

-- Column count
select count(*) from information_schema.columns where table_name = "orders";
select count(*) from information_schema.columns where table_name = "restaurants";

-- Row count
select count(*) from orders;
select count(*) from restaurants;

-- Joining both Orders and Restaurants.
select restaurants.RestaurantID,restaurants.RestaurantName,restaurants.City,
orders.orderID,orders.CustomerID,orders.RestaurantID, orders.cookiesShipped,
orders.revenue,orders.cost,orders.profit,orders.orderDate,orders.shipDate,
orders.dateDifference,orders.orderStatus
from orders
join restaurants
on orders.RestaurantID = restaurants.RestaurantID; 

-- What is the total revenue generated by each restaurant?
select restaurantname, round(sum(revenue)) as Total_Revenue 
from orders o
join restaurants r 
ON o.restaurantID = r.restaurantID
group by restaurantname
limit 5;

-- How has the total revenue changed over time (monthly/yearly) --
-- Monthly -- Yearly --
select date_format(orderDate, "%Y:%M") as YearMonth, round(sum(revenue)) as total_revenue 
from orders
group by YearMonth
order by YearMonth desc;

-- What are the top 5 restaurants based on total revenue --
select restaurantName,round(sum(revenue)) as total_revenue 
from orders o
join restaurants r 
on o.restaurantID = r.restaurantID
group by restaurantName
order by total_revenue desc 
limit 5;

-- *What is the average revenue per order --
select orderID,round(avg(revenue)) as avg_revenuePer_Order
from orders
group by orderID;

-- . *Order volume by restaurants --
 select RestaurantName,count(OrderID) as Total_Orders
 from orders a
join restaurants b 
ON a.RestaurantID = b.RestaurantID
group by RestaurantName
order by Total_Orders desc;

-- Average shipping time by restaurants --
 select b.RestaurantName,b.City, round(Avg(a.DateDifference)) as Avg_Shipped_Time
 from orders a
 join restaurants b
 on a.RestaurantID=b.RestaurantID
 group by RestaurantName, City
order by Avg_Shipped_Time;
 
 -- What is the average number of cookies shipped per order?
 select  round(avg(cookiesShipped)) as avg_cookiesShipped
 from orders;

-- What is the average order processing time (order date to ship date)?
select avg(datediff(shipdate, orderdate)) as avg_processing_time 
from orders;

-- Order volume over time August(2023)
select RestaurantName, day(OrderDate) as day, count(OrderID) as Orders
from orders a
join restaurants b
on a.RestaurantID=b.RestaurantID
group by RestaurantName, day(OrderDate)
order by day;

-- What is the total profit generated by each restaurant?
select b.RestaurantName, round(sum(a.profit)) as profit_generated
from orders a
join restaurants b
on a.RestaurantID=b.RestaurantID
group by RestaurantName;

-- How has the total profit changed over time (monthly/yearly)?
 select date_format(orderDate, "%Y:%M") as Month_Year, round(sum(profit)) as total_profit 
from orders
group by Month_Year
order by Month_Year desc;
 
-- Which orders generated the highest profit?
  select orderID, restaurantname, round(max(profit)) as highest_profit
  from orders a
  join restaurants b
  on a.RestaurantID=b.RestaurantID
  group by orderID, restaurantname
  order by  highest_profit desc;
  
-- What is the profit margin (profit as a percentage of revenue) for each restaurant?
select RestaurantName, round(sum(profit)) as total_profit, round(sum(revenue)) as total_revenue,    
sum(profit) / sum(revenue) * 100 as profit_margin
 from orders a
 join restaurants b
 on a.RestaurantID=b.RestaurantID
 group by restaurantName
 order by profit_margin desc;
 
-- What is the total cost incurred by each restaurant?
select RestaurantName, round(sum(cost)) as total_cost_by_restaurant
from orders a
join restaurants b
on a.RestaurantID=b.RestaurantID
group by RestaurantName;

-- How has the total cost changed over time (monthly/yearly)?
select date_format(orderDate, "%Y:%M") as Month_Year, round(sum(cost)) as total_cost 
from orders
group by Month_Year
order by Month_Year desc;
 
--- What are the top 3 orders based on cost? ---
select OrderID,  RestaurantName, round(sum(cost)) as Total_Cost
 from orders a
 join restaurants b
 on a.RestaurantID=b.RestaurantID
 group by OrderID,  RestaurantName
 order by Total_Cost desc
 limit 3;
 
-- What is the average cost per order? --
select orderID, round(avg(cost)) as avg_costper_order
from orders
group by orderID;

-- How does the shipping time vary across different order statuses --
select orderStatus,round(avg(datediff(shipDate,orderDate))) as average_shippingTime
from orders
group by orderStatus;

-- Which month had the highest average shipping time--
select date_format(orderdate, "%Y-%M") as month_year, round(avg(datediff(shipDate,orderDate)))
 as average_shippingTime
from orders
group by month_year
order by month_year desc
limit 1;

-- How many orders were shipped within 1 day, 2 days, 3 days, etc. --
select datedifference, count(orderID) AS no_of_orders from orders
where datedifference <=3
group by datedifference
order by datedifference DESC
limit 5;

-- Which cities have the highest number of orders --
 select * from orders;
 select * from restaurants;
 select b.city, count(a.orderID) AS Num_of_Orders
 from orders  a
 join restaurants b
 on a.RestaurantID = b.RestaurantID
 group by b.city
 order by Num_of_Orders desc;
 
-- How does the average order value vary across different cities?
 select b.city, round(avg(a.revenue)) as average_order
from restaurants b
join orders a
where RestaurantName is not null
group by  b.city
order by average_order;

-- *Order Status Analysis:*
-- What is the proportion of orders in each status (Delivered, Pending, Canceled)?
SELECT orderstatus, COUNT(orderID) AS order_count, 
COUNT(orderID) / (SELECT COUNT(*) FROM orders) * 100 AS proportion
from orders
group by orderStatus;

-- How does the revenue and profit compare across different order statuses?
select orderStatus, round(sum(revenue)) as total_revenue, round(sum(profit)) as total_profit
from orders
group by orderStatus;


