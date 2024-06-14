--Create database sqlcaptsoneproject;

--Create table amazon(
    invoice_id VARCHAR(30),
    branch VARCHAR(5),
    city VARCHAR(30),
    customer_type VARCHAR(30),
    gender VARCHAR(10),
    product_line VARCHAR(100),
    unit_price DECIMAL(10, 2),
    quantity INT,
    VAT FLOAT,
    total DECIMAL(10, 2),
    date DATE,
    time TIMESTAMP,
    payment_method DECIMAL(10, 2),
    cogs DECIMAL(10, 2),
    gross_margin_percentage FLOAT,
    gross_income DECIMAL(10, 2),
    rating FLOAT
);

--Feature Engineering.
--Add a new column named timeofday to give insight of sales in the Morning, Afternoon and Evening. 
--This will help answer the question on which part of the day most sales are made.

--Select *, 
--Case
---When time<='12:00:00' then 'Morning'
---When time>='12:00:00' and time<'17:00:00' then 'Afternoon'
--ELSE 'Evening'
--END AS timeofday
--FROM amazon;

--Add a new column named dayname that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.

--Alter table amazon
--Add dayname VARCHAR(20)
--Update amazon
---Set dayname = LEFT(DATENAME(WEEKDAY, date), 3);

--Select Count(*) as total_rows from amazon;

--SELECT COUNT(*) AS total_columns
--FROM INFORMATION_SCHEMA.COLUMNS
--WHERE TABLE_SCHEMA = 'sqlcapstoneproject';


--Add a new column named monthname that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.

--Alter table amazon
--Add monthname VARCHAR(20)
--Update amazon
--Set monthname= LEFT(DATENAME(MONTH, date), 3);



#1.What is the count of distinct cities in the dataset?
--Select Count(distinct City) from amazon;
--The count of distinct city is 3.

#2.For each branch, what is the corresponding city?
--Select Distinct(Branch), City from amazon;
--For Branches A,B,C the corresonding cities are Yangon, Naypyitaw and Mandalay.

#3.What is the count of distinct product lines in the dataset?
--Select Count(Distinct Product_line) from amazon;
--The count of distinct product line is 6.


#4.Which payment method occurs most frequently?
--Select Payment, Count(*) AS 'Most_FREQ_PYMNT_METHOD' from amazon Group by Payment Order by Most_FREQ_PYMNT_METHOD DESC;
--The payment method Ewallet occurs most frequently.

#5.Which product line has the highest sales?
--Select Product_line, SUM(gross_income) from amazon Group by Product_line Order by SUM(gross_income) DESC LIMIT 1;
--The product line Food and beverages has the highest sales.


#6.How much revenue is generated each month?
--Select monthname, sum(gross_income) from amazon group by monthname;

#7.In which month did the cost of goods sold reach its peak?
--Select monthname, SUM(cogs) from amazon group by monthname Order by SUM(cogs) DESC LIMIT 1;
--The cost of goods sold reach its peak in Jan.


#8.Which product line generated the highest revenue?
--Select Product_line, SUM(gross_income) from amazon group by Product_line Order by SUM(Total) DESC LIMIT 1;
--Food and beverages.

#9.In which city was the highest revenue recorded?
--Select City, SUM(gross_income) from amazon group by City order by SUM(Total) DESC LIMIT 1;
--Naypyitaw.


#10.Which product line incurred the highest Value Added Tax?
--Select Product_line, MAX(VAT) from amazon group by Product_line Order by MAX(VAT) DESC Limit 1;
--Fashion accessories
#11.For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."

SELECT Product_line,
CASE
WHEN SUM(Total) > AVG(Total) THEN 'Good'
ELSE 'Bad'
END AS Indicator
FROM amazon
group by Product_line;


#12.Identify the branch that exceeded the average number of products sold.

--Select Branch, Avg(quantity) from amazon group by Branch;
--Select Branch, SUM(quantity) AS "Products_Sold", Avg(Quantity) from amazon group by Branch Having Products_Sold > Avg(Quantity);
--Branch A has exceeded the average number of products sold.


#13.Which product line is most frequently associated with each gender?

--Select Gender, Max(Product_line) from amazon Group by Gender;
--Sports and travel.

#14.Calculate the average rating for each product line.

--Select Product_line, AVG(Rating) from amazon group by Product_line;

#15.Count the sales occurrences for each time of day on every weekday.

--Select timeofday, dayname ,Count(Total) AS 'Sales_Occurr' from amazon group by timeofday, dayname;

#16.Identify the customer type contributing the highest revenue.

--Select Customer_type, SUM(gross_income) from amazon group by Customer_type Order by SUM(Total) DESC LIMIT 1;
--Member is the customer type contributing the highest revenue.


--17.Determine the city with the highest VAT percentage.

--Select City, MAX(VAT) from amazon group by City order by Max(VAT) DESC Limit 1;
--Naypyitaw

#18.Identify the customer type with the highest VAT payments.

--Select Customer_type, MAX(VAT) from amazon group by Customer_type order by Max(VAT) DESC Limit 1;
--Member

#19.What is the count of distinct customer types in the dataset?

--Select Count(distinct Customer_type) from amazon;

#20.What is the count of distinct payment methods in the dataset?

--Select Count(distinct Payment) from amazon;
#21.Which customer type occurs most frequently?
--Select MAX(Customer_type) from amazon;

#22.Identify the customer type with the highest purchase frequency.

--Select Customer_type, Count(Total) from amazon group by Customer_type Order by  Count(Total) DESC Limit 1;
--Member


#23.Determine the predominant gender among customers.
--Select Gender, Count(*) as "Predom_Gen" from amazon Group by Gender Order by Predom_Gen DESC LIMIT 1;
--Female

#24.Examine the distribution of genders within each branch.
--Select Branch, Gender, Count(*) As 'Gen_Dist' from amazon group by Branch, Gender Order by Gen_Dist DESC;


--25.Identify the time of day when customers provide the most ratings.
--Select timeofday, Count(Rating) from amazon group by timeofday order by  Count(Rating) DESC Limit 1;
--Afternoon

#26.Determine the time of day with the highest customer ratings for each branch.
--Select  Branch, timeofday, MAX(Rating) from amazon group by timeofday, Branch order by MAX(Rating) DESC;

#27.Identify the day of the week with the highest average ratings.
--Select dayname, AVG(Rating) from amazon group by dayname order by AVG(Rating) DESC Limit 1;
--Mon.

#28.Determine the day of the week with the highest average ratings for each branch.
--Select dayname, Branch, AVG(Rating) from amazon group by dayname, Branch order by AVG(Rating) DESC;

Analysis List
Product Analysis
1. There are 6 distinct product lines- Health and beauty, Electronic accessories, Home and lifestyle, Sports and travel, Food and beverages,Fashion accessories.
2.The product line Food and beverages has the highest sales.
3.Health and beauty generates lower revenue and it needs improvement.

Sales Analysis
1.Branch A has comparatively generated higher revenue than Branch B & C. There is need of improvement in sales of Branch B&C by giving more good offers.
2. Member is the customer type contributing the highest revenue. Discounts and good offers should be given to Members so that Normal customers convert to Member.
3. Ewallet is the payment method which generates the highest revenue and used most frequently. More discount and good offers should be given to improved sales on Cash and Credit Card as well.

Select Distinct Customer_type from amazon;

Customer Analysis
1. Memeber contributes the most to generating revenue.
2. Most of the customers visit during Afternoon, so the staff should be more active at cash counter.
3. Female is the predominant gender among customers in Branch A. More strategic planning should be done to attract more customers from Branch B&C including males customers as well.






