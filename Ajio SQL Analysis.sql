create database ajio;

use ajio;

create table customer (
c_id varchar(15) primary key , 
C_Name varchar (25) , 
Gender varchar(10),
Age int , 
city varchar(25),
state varchar(25) ,
street_address varchar(100),
mobile bigint ) ;


create table Delivary ( 
DP_ID varchar(15) ,
DP_Name varchar(15),
DP_Rating  int,
percent_cut int );

Alter table Delivary 
add primary key (DP_ID);




create table orders ( 
Or_id varchar(15) primary key,
C_id VARCHAR(15),
P_id varchar(15),
Order_date date ,
order_time time , 
Qty int ,
coupoun varchar(25),
DP_ID VARCHAR(15),
Discount int ,
foreign key (C_id)  references  customer(c_id));

Alter table orders Add	constraint fk_orders 
foreign key (P_id) references products(P_id);

Alter table orders Add constraint FK_Delivary 
foreign key (DP_ID) references Delivary(DP_ID);

create table products(
P_id varchar(15) primary key,
P_Name varchar(100),
category varchar(20),
Company_name varchar(25),
Gender varchar(15),
price int);

select * from products;

create table ratings (
R_id varchar(15) primary key , 
Or_id varchar(15) ,
product_rating int , 
delivery_service_Rating int ,
foreign key (Or_id) references orders(Or_id));

create table returns(
RT_id varchar(15) primary key, 
Or_id varchar(15) ,
Reason varchar(75),
Return_Refund varchar(30),
dates date , 
foreign key (Or_id) references orders(Or_id));

Create table Transactions(
T_id varchar(15) primary key,
Or_id varchar(15) , 
Transaction_Mode varchar(25),
Reward varchar(10) , 
foreign key (Or_id) references orders(Or_id));

-- day 1 
# Sales and revenue analysis 

-- 1.	What are the top 10 products that generated the highest total revenue?
use ajio;

SELECT 
    P.P_id, P.P_Name, SUM(O.Qty * P.price) AS Total_Revenue
FROM
    orders O
        INNER JOIN
    Products P ON O.P_id = P.P_id
GROUP BY P.P_id , P.P_Name
ORDER BY Total_Revenue DESC
LIMIT 10;

-- 2. Which product categories contribute the most to total sales?

SELECT 
    P.category, SUM(O.Qty * P.Price) AS Total_sales
FROM
    Products P
        INNER JOIN
    Orders O ON P.P_id = O.P_id
GROUP BY P.Category
ORDER BY Total_sales DESC
LIMIT 5;


-- 3.	What is the monthly sales trend over the last year?

SELECT 
    MONTH(Order_date) AS month, SUM(O.Qty * P.price) AS sales
FROM
    orders O
        INNER JOIN
    Products P ON O.P_id = P.P_id
GROUP BY MONTH(Order_date)
ORDER BY sales;

-- 4.	Which companies’ products are most preferred by customers?

SELECT 
    P.Company_name AS company_name,
    P.P_Name AS product_name,
    SUM(O.Qty * P.Price) AS Total_sales
FROM
    Products P
        INNER JOIN
    Orders O ON P.P_id = O.P_id
        INNER JOIN
    Customer C ON O.C_id = C.c_id
GROUP BY P.company_name , P.P_Name
ORDER BY Total_sales
LIMIT 10;


-- 5.	What is the average order value (AOV) across all customers?

SELECT 
    SUM(o.Qty * P.Price) / COUNT(DISTINCT O.Or_id) AS AOV
FROM
    products P
        INNER JOIN
    Orders O ON P.P_id = O.P_id;


# Customer beaviour Analysis 

-- 6.	Which customers have placed the highest number of orders?

select C.C_Name ,count(O.Or_id) as orders_freq   from customer C inner join Orders O on C.C_id = O.C_id 
group  by C.C_Name order by orders_freq desc;

-- 7.	What is the total spending of each customer and their average order frequency?

SELECT 
    C.C_Name,
    SUM(O.Qty * P.price) AS total_spend,
    ROUND(SUM(O.Qty * P.Price) / COUNT(O.Or_id), 2) AS avg_order_value
FROM
    Products P
        INNER JOIN
    Orders O ON P.P_id = O.P_id
        INNER JOIN
    Customer C ON O.C_id = C.c_id
GROUP BY C.C_Name
ORDER BY total_spend DESC limit 10;

-- 8.	How does gender influence the type of products purchased?
use ajio;
SELECT 
    C.Gender, P.category, COUNT(O.or_id) AS Total_Purchases
FROM
    products P
        INNER JOIN
    Orders O ON P.P_id = O.P_id
        INNER JOIN
    customer C ON C.c_id = O.C_id
GROUP BY C.Gender , P.category
ORDER BY Total_Purchases DESC;

-- 9.	Which cities or states have the highest sales volume?

SELECT 
    C.city AS city, SUM(O.Qty * P.Price) AS Total_sales
FROM
    customer C
        INNER JOIN
    Orders O ON O.C_id = C.c_id
        INNER JOIN
    Products P ON P.P_id = O.P_id
GROUP BY C.city
ORDER BY Total_sales DESC
LIMIT 5;

-- 10.	Identify loyal customers who make repeated purchases frequently.
use ajio;

SELECT 
    C.c_id, C.C_Name, COUNT(O.Or_id) AS purchase_count
FROM
    Customer C
        INNER JOIN
    Orders O ON C.c_id = O.C_id
GROUP BY C.c_id , C.C_Name
HAVING purchase_count < 5
ORDER BY purchase_count DESC limit 10 ;

-- Discounts and Promotions 
-- 11.	How do discounts and coupons affect the total revenue and sales volume?

SELECT 
    P.P_Name,
    SUM(O.Qty * P.price) AS total_Sales,
    O.coupoun,
    COUNT(O.Or_id) AS No_of_Orders,
    SUM(O.Qty) AS total_Qty,
    O.Discount AS discount,
    SUM(O.Qty * P.Price * (1 - O.discount / 100)) AS Net_revenue 
FROM
    products P
        INNER JOIN
    Orders O ON P.P_id = O.P_id
GROUP BY P.P_Name , O.coupoun , O.Discount order by discount desc;

-- 12.	What percentage of orders were made using coupons versus without? 

use ajio;

select  count(*) as total_orders  , 
sum(case when coupoun = 'No Coupon' then 1 else 0 end ) * 100 / count(*) as no_coupoun_percent , 
sum(case when coupoun <> 'No Coupon' then 1 else 0 end ) * 100 / count(*) as coupoun_percent
 from orders ;


-- 13.	Which coupon codes led to the highest sales?
use ajio;
SELECT 
    coupoun, SUM(O.Qty * P.Price) AS Total_sales
FROM
    orders O
        INNER JOIN
    products P ON O.P_id = P.P_id
GROUP BY coupoun
ORDER BY Total_sales ASC;
 
 -- Returns and Ratings 
 
 -- 14.	Which products have the highest return rates, and what are the common return reasons?
 
SELECT 
    P.P_Name, R.Reason, COUNT(R.RT_id) AS Freq_RT_id
FROM
    orders O
        INNER JOIN
    products P ON O.P_id = P.P_id
        LEFT JOIN
    returns R ON O.Or_id = R.Or_id
GROUP BY P.P_Name , R.Reason
ORDER BY Freq_RT_id DESC;

--  15.	What is the average product rating by category and company?

SELECT 
    P.Company_name,
    P.category,
    AVG(R.product_rating) AS avg_rating
FROM
    products P
        INNER JOIN
    Orders O ON P.P_id = O.P_id
        LEFT JOIN
    ratings R ON O.Or_id = R.Or_id
GROUP BY P.Company_name , P.category; 

-- Delivery and Service perfomence 

-- 16.	Which delivery personnel (DP_ID) have the highest average delivery ratings?

SELECT 
    DP_id, ROUND(AVG(DP_Rating), 0) AS avg_rating
FROM
    delivary
GROUP BY DP_id
ORDER BY avg_rating DESC;


-- 18 Identify the correlation between delivery rating and order repeat rate

SELECT 
    C.C_Name AS Customer_Name,
    COUNT(O.Or_id) AS total_orders,
    ROUND(AVG(R.delivery_service_Rating), 2) avg_rating_delivery
FROM
    orders O
        INNER JOIN
    customer C ON C.c_id = O.C_id
        INNER JOIN
    ratings R ON O.Or_id = R.Or_id
GROUP BY C.C_Name
ORDER BY avg_rating_delivery DESC;


-- Profitability and efficiency 
-- 19 Which products generate the highest profit margins (price − discount)?
SELECT 
    P.P_Name,
    SUM(P.price * O.Qty) AS total_sales,
    O.Discount,
    SUM((P.Price * O.Qty) - ((P.Price * O.Qty) * (O.Discount / 100))) AS margin
FROM
    products P
        INNER JOIN
    Orders O ON O.P_id = P.P_id
GROUP BY P.P_Name , O.Discount
ORDER BY margin desc;

-- 20 Which customers or locations provide the highest revenue with the lowest returns?
use ajio;

SELECT 
    C.C_Name AS Customer_Name,
    SUM(O.Qty * P.price) AS total_Revenue,
    COUNT(RT_id) AS freq_returns
FROM
    products P
        INNER JOIN
    Orders O ON P.P_id = P.P_id
        INNER JOIN
    Customer C ON C.c_id = O.C_id
        LEFT JOIN
    returns R ON R.Or_id = O.Or_id
GROUP BY C.C_Name
ORDER BY total_Revenue DESC , freq_returns ASC;
	









