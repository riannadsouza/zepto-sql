

drop table if exists zepto;

create table zepto (
sku_id serial primary key,
category varchar(120),
name varchar(150) not null, 
mrp numeric (8,2),
discountPercent numeric (5,2),
availableQuantity integer,
discountedSellingPrice NUMERIC (8,2),
weightInGms integer,
outOfStock boolean ,
quantity integer
)   

--data exploration 

--count of rows 
select count (*) from zepto;

--sample data 
select * from zepto 
limit 5;

--null values
select * from zepto
where name is null
OR category is  null
OR mrp is null
OR discountpercent is null
OR availablequantity is null
OR weightingms is null
OR outofstock is null
OR quantity is null;

--different product categories
select distinct category 
from zepto
order by category;

--products in stock and out of stock 
Select outofstock, count(sku_id)
from zepto 
group by outofstock;

--products names present multiple times
Select name, count(sku_id) as "no of skus"
from zepto 
group by name 
having count(sku_id)>1
order by count(sku_id) desc;

--data cleaning 

--products with price = 0
select * from zepto 
where mrp = 0 or discountedsellingprice= 0;

delete from zepto 
where mrp = 0;

--convert paise to rupees
update zepto 
set mrp = mrp/100,
discountedsellingprice = discountedsellingprice/100;

Select mrp, discountedsellingprice
from zepto;

--1. Find the top 10 best value products based on the discount percentage?
Select distinct name, mrp, discountpercent 
from zepto 
order by discountpercent desc 
limit 10;

Which product category has the highest average selling price?
Select category, round(avg(discountedsellingprice),2) as avg_price
from zepto
group by category 
order by avg_price desc 
limit 1;

--2. Which category has the most products?
select category, count(*) as total_products
From zepto
group by category 
order by total_products desc;

--2. What are the products with high mrp but out of stock ?
select distinct name, mrp, outofstock 
from zepto
where outofstock = TRUE 
order by mrp desc 

--3. Calculate the estimated revenue for each category?
Select distinct category, sum(discountedsellingprice * availablequantity) as total_revenue
from zepto 
group by category 
order by total_revenue;

--4. Find all the products where the mrp is greater than 500 and discount is less than 10%.
Select distinct name, mrp, discountpercent 
from zepto 
where mrp > 500 and discountpercent < 10 
order by mrp desc, discountpercent desc;

Which products offer a discount greater than the average discount?
Select name, discountpercent 
from zepto 
where discountpercent>
(Select avg(discountpercent) from zepto)

--5. Identify the top 5 categories offering the highest average discount percentage?
Select category, round(avg(discountpercent),2) as avg_discount
from zepto 
Group by category 
order by avg_discount desc
limit 5;

--6. Find the price per grams for products above 100g and sort by best value.
Select distinct name, weightingms, discountedsellingprice, Round(discountedsellingprice/weightingms,2) as price_per_gm
from zepto 
Where weightingms >= 100
order by price_per_gm;

How can products be classified based on their discount?
Select distinct name, discountpercent,
case when discountpercent= 0 then 'No discount'
     when discountpercent <= 10 then 'Low discount'
	 when discountpercent <=30 then 'Medium discount'
	 Else 'high discount'
	 end as discount_category 
	 from zepto;

--8. Group the catogeries into like Low, Meduim, Bulk 
Select distinct name, weightingms,
Case when weightingms < 1000 then 'low'
     when weightingms < 5000 then 'medium'
     Else 'bulk'
     end as weight_category
from zepto;