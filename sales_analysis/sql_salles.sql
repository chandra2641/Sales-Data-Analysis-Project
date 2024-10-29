-- 1. Basic Queries
-- o Write a query to find the total sales amount for each product.

select  distinct Product_Name, 
sum(Total_Sales) as total_sales 
from sales
group by 1;

-- o Retrieve the top 5 products with the highest sales.

select distinct Product_Name,
Quantity_Sold from sales
order by 2 desc
limit 5;

-- o Find the total quantity sold per region.

select distinct region, sum(Quantity_Sold) 
as Quantity_Sold
from sales
group by 1;

-- 2. Aggregation and Grouping
-- o Write a query to calculate the total sale and average price per unit for each category.

select distinct Category,Total_Sales,
round(avg(Price_per_Unit),2) as avg_Price_per_Unit 
from sales
group by Category,Total_Sales;

-- o List the total sales per month across all regions. [ wrong ]

select distinct Region,Total_Sales,
extract(month from Date) as month_
from sales;

-- o Identify the product with the highest sales in each category.

select Product_Name ,Category ,
sum(Quantity_Sold) as high_sales from sales
group by Product_Name ,Category;

-- 3. Filtering and Conditions
-- o Retrieve all sales records where the quantity sold is more than 5.

select * from sales
where Quantity_Sold > 5;

-- o Find the records where total sales exceed $500

select* from sales
where Total_Sales 
between 500 and 600;

-- o Write a query to filter out sales made in the ‘North’ region.

select* from sales
where Region = "North";

-- 4. Advanced Queries
-- o Find the cumulative sales for each region, ordering by date.

select Date,
Total_Sales,
sum(Total_Sales) over (order by date) 
as cumulative_sales from sales;

-- o Identify which category contributed the most to total sales for the year.

select Category,date,sum(Total_Sales) as tota_sales 
from sales
group by Category,date
order by 2 desc;

-- o Write a query to calculate month-over-month growth in total sales.

SELECT 
    date,
    Total_Sales,
    LAG(Total_Sales) OVER (ORDER BY date) AS Previous_Month_Sales,
    CASE 
        WHEN LAG(Total_Sales) OVER (ORDER BY date) IS NULL THEN 0
        ELSE round(((Total_Sales - LAG(Total_Sales) OVER (ORDER BY date)) / LAG(Total_Sales) OVER (ORDER BY date)) * 100,2)
    END AS MoM_Growth_Percentage
FROM 
    sales;
