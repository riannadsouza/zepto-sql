# zepto-sql

## Overview
 This project is a SQL-based analysis of Zepto product data. The main goal of this project is to explore the product dataset, clean some of the data, and answer different business related questions using SQL. I have used PostgreSQL to create the table, perform data cleaning, and analyze products, categories, prices, discounts, stock, and quantities.

## Data Dictionary

| Column | Data Type | Description |
|---|---|---|
| `sku_id` | `SERIAL` | Unique ID for each product |
| `category` | `VARCHAR` | Product category |
| `name` | `VARCHAR` | Product name |
| `mrp` | `NUMERIC` | Maximum Retail Price |
| `discountPercent` | `NUMERIC` | Discount percentage |
| `availableQuantity` | `INTEGER` | Available product quantity |
| `discountedSellingPrice` | `NUMERIC` | Selling price after discount |
| `weightInGms` | `INTEGER` | Product weight in grams |
| `outOfStock` | `BOOLEAN` | Whether the product is out of stock |
| `quantity` | `INTEGER` | Product quantity |


## What I Did in This Project
1.	Data Exploration
 First, I explored the dataset to understand what kind of data was available. I checked: 
- Total number of rows 
- Sample records
 - Missing values 
- Different product categories
 - Products that are in stock or out of stock 
- Product names that appear multiple times

2.	Data Cleaning 
I performed some basic cleaning before starting the analysis. The main cleaning steps were: 
- Finding products where the price was 0 
- Removing products with an MRP of 0 
- Converting prices from paise to rupees



## Key Questions Answered 
After cleaning the data, I used SQL queries to answer different questions.

1.Find the top 10 best value products based on the discount percentage?

2. Which product category has the highest average selling price?

3. Which category has the most products?

4. What are the products with high mrp but out of stock ?

5. Calculate the estimated revenue for each category?

6. Find all the products where the mrp is greater than 500 and discount is less than 10%.

7. Identify the top 5 categories offering the highest average discount percentage?

8. Which categories have the highest total quantity of products available?

9. Find the price per grams for products above 100g and sort by best value.

10. How can products be classified based on their discount?

11. Group the catogeries into like Low, Meduim, Bulk 


## SQL Concepts Used
Through this project, I worked with several SQL concepts:

•	SELECT 

•	WHERE 

•	GROUP BY 

•	ORDER BY 

•	HAVING 

•	DISTINCT 

•	COUNT() 

•	SUM() 

•	AVG() 

•	ROUND() 

•	CASE 

•	DELETE 

•	UPDATE 

•	Aggregate functions 

•	Filtering and sorting 

•	Basic data cleaning

## Sql analysis and queries 

### 1.Find the top 10 best value products based on the discount percentage?
```sql
Select name, mrp, discountpercent 
from zepto 
order by discountpercent desc 
limit 10;
```

### 2.Which product category has the highest average selling price?
```sql
Select category, round(avg(discountedsellingprice),2) as avg_price
from zepto
group by category 
order by avg_price desc 
limit 1;
```

### 3.Which category has the most products?
```sql
select category, count(*) as total_products
From zepto
group by category 
order by total_products desc;
```

### 4. What are the products with high mrp but out of stock ?
```sql
select name, mrp, outofstock 
from zepto
where outofstock = TRUE 
order by mrp desc;
```

### 5. Calculate the estimated revenue for each category?
```sql
Select category, sum(discountedsellingprice * availablequantity) as total_revenue
from zepto 
group by category 
order by total_revenue;
```

### 6. Find all the products where the mrp is greater than 500 and discount is less than 10%.
```sql
Select name, mrp, discountpercent 
from zepto 
where mrp > 500 and discountpercent < 10 
order by mrp desc, discountpercent desc;
```

### 7. Identify the top 5 categories offering the highest average discount percentage?
```sql
Select category, round(avg(discountpercent),2) as avg_discount
from zepto 
Group by category 
order by avg_discount desc
limit 5;
```

### 8. Which categories have the highest total quantity of products available?
```sql
Select category, sum(quantity) as total_quantity
from zepto 
group by category
order by total_quantity desc;
```

### 9. Find the price per grams for products above 100g and sort by best value.
```sql
Select name, weightingms, discountedsellingprice, Round(discountedsellingprice/weightingms,2) as price_per_gm
from zepto 
Where weightingms >= 100
order by price_per_gm;
```

### 10. How can products be classified based on their discount?
```sql
Select name, discountpercent,
case when discountpercent = 0 then'No discount'
     when discountpercent < 10 then'Low discount'
	 when discountpercent < 30 then'Medium discount'
	 Else 'High discount'
end as discount_category 
	 from zepto;
```

### 11. Group the catogeries into like Low, Meduim, Bulk 
```sql
Select name, weightingms,
Case when weightingms < 1000 then 'low'
     when weightingms < 5000 then 'medium'
     Else 'bulk'
     end as weight_category
from zepto;
```



## Key Learning
This project helped me understand how SQL can be used to work with real-world business data.
I learned how to:


•	Explore an unfamiliar dataset 

•	Find and handle missing or incorrect data 

•	Clean numerical values 

•	Group data by categories 

•	Calculate averages and totals 

•	Use conditional logic with CASE 

•	Answer business questions using SQL 

•	Organize SQL queries into an analysis workflow 
________________________________________
## Tools Used

•	PostgreSQL 

•	SQL 


## Conclusion
This project is a basic SQL analysis of Zepto product data. It focuses on understanding the data and using SQL to answer practical questions related to products, pricing, discounts, stock, quantity, and revenue.
It was also a good practice project for improving my SQL skills and understanding how SQL can be applied to business data.





